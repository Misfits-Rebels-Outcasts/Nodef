//
//  CustomShader.metal
//  arsimplesea
//
//  Created by Yasuhito NAGATOMO on 2022/03/16.
//

#include <metal_stdlib>
#include <RealityKit/RealityKit.h>
using namespace metal;
#include "helpers.h"

[[visible]]
void geometryModifier(realitykit::geometry_parameters params)
{
    
    //float3 pos = params.geometry().model_position();
    float time = params.uniforms().time();


    float2 uv = params.geometry().uv0();
    uv.y = 1.0 - uv.y;
    
    
    //not using at the moment
    
    
    //step 1 : generate fbm toproduce displacement map
    //to offset the geometry of each vertex
  
    float timefactor = 1.0;
    float warpType = 0.0;
    float angle = 0.0;
    float scale = 1.25;
    float2 animVelocity = float2( 0.12, 0.09);
    float2 uvscale =uv*scale;
    
    float divfactor = 1.0;
    //float screensize = 2048;
   
    time = 0;
    float4 val =
    fBMheightmapx(uvscale,time*timefactor/divfactor ,warpType,animVelocity,angle);
    //val = pow(1.6*val,2.3);
    val = pow(1.7*val,2.5);
    
    
   
    
    //variations
    //time = 0;
    //float4 val = fBMFlow(uv, float2(1024,1024), float3(0,0,0), time*3);
   
   
    float dist = length(uv);
    if (dist>0.96)
        val = float4(0.05);
    //if (val.r<0.1)
     //   val.r = 0.1;
    
    //displacement map not working well
    float3 offset = float3(0.0,0.063*val.r,0.0);
    
    //float3 offset = val.xyz*0.05;
    
    //float disp = sqrt(uv.x*uv.x+uv.y*uv.y)*0.1;
    //float3 offset = float3(0.0,disp,0.0);
    params.geometry().set_model_position_offset(offset);
    
    
   
    
    //params.geometry().set_model_position_offset(params.geometry().normal() *0.03*val.xyz);
    
    /*
    
    //float2 uv = params.geometry().uv0();
    // x axis: wave length = 0.2 [m], cycle = 8.0 [sec]
    // z axis: wave length = 0.3 [m], cycle = 10.0 [sec]
    // wave height = +/- 0.005 [m]
    float3 offset = float3(0.0,
                           2*cos( 3.14 * 2.0 * (pos.x) / 0.2 + 3.14 * 2.0 * params.uniforms().time() / 8.0 )
                         * 2 * cos( 3.14 * 2.0 * pos.z / 0.3 + 3.14 * 2.0 * params.uniforms().time() / 10.0 ) * 0.005,
                           0.0);
    params.geometry().set_model_position_offset(offset);
     */
     
}




[[visible]]
void surfaceShader(realitykit::surface_parameters params)
{
    float time = params.uniforms().time();


    float2 uv = params.geometry().uv0();
    uv.y = 1.0 - uv.y;


    //half3 color = (half3)params.material_constants().base_color_tint(); // for base color (tint)
   // half3 color1 = color * ((sin(time) / 2 + 0.5) * 0.8 + 0.2); // Color(t): animate colors

    
    //ver 5.0
    //fBMFlow(pos , sizeImage, org, iTime)
    float timefactor = 1.0;
    
    //stationary wave
    time = 0;
    
    float4 val = fBMFlow(uv, float2(2048,2048), float3(0,0,0), time*timefactor);
    
    
    //ver 5.1
    float warpType = 0.0;
    float angle = 0.0;
    float scale = 1.25;
    float2 animVelocity = float2( 0.12, 0.09);
    float2 uvscale =uv*scale;
    
    float divfactor = 4.0;
    float screensize = 2048;
    
   
    float3 normal = computeNormal(uvscale,time*timefactor/divfactor ,warpType,animVelocity,angle,screensize);
    
    //ver 5.1
    //float4 val =
    //heightmapx(uvscale,time*timefactor/divfactor ,warpType,animVelocity,angle);
   
   
    
    //half3 color1 = half3(1,1,1);
    half3 color1 = half3(0.5,0.7,0.9);
    //half3 color2 = half3(0.9,0.8,0.9);
    //half3 color1 = half3(1.0,0.5,0.9);
   
    
  
    
    half halfr = val.r;
    half halfg = val.g;
    half halfb = val.b;
    
    
    
    color1 = half3(halfr,halfg,halfb);
 
    
    
    //ver 5.1

    normal = normalize(normal);
    //normal.xy *= 3.0;
    //normal = normalize(normal);
    
    
    //step 2 : set normals using normals computed from the same fbm heightmap
    params.surface().set_normal(normal); //set tangent space normal
    
    
    
   /*
    //not working
    //step 3  : blend the 2 shader colors for voxels near each other
    //height of terrain
    float timex = 0;
    float4 hterrian = fBMheightmapx(uvscale,timex*timefactor/divfactor ,warpType,animVelocity,angle);

    hterrian = pow(1.7*val,2.5);
    float hterrianval = 0.063*hterrian.r;
   
    //height of water level
    timex = time;
    float4 hwater =
    fBMheightmapx(uvscale,timex*timefactor/divfactor ,warpType,animVelocity,angle);
    hwater = pow(1.7*val,2.1) + 0.023; //0.023 is the height of water plane
    float hwaterval = 0.05*hwater.r;
    
    //color of water at this pos
    float4 watercolor = fBMFlow(uv, float2(2048,2048), float3(0,0,0), timex*timefactor,112,3.0,3.0);
    
    
    //blend if heights are near
    float dist = hterrianval - hwaterval;
   // if ((dist>0) && (dist<0.0012))
    if (dist>0)
    {
     
        float wt = 1.0/0.0012;
        float4 result = mix(val,watercolor,dist*wt);
            
            half halfr = result.r;
            half halfg = result.g;
            half halfb = result.b;
    
            //reassign color
            color1 = half3(halfr,halfg,halfb);
         
    }
    */
    
    
    //if (abs(hterrianval - hwaterval)<0.0012)
    //{
    //    color1.r = (color1.r + watercolor.r) * 0.5;
    //    color1.g = (color1.g + watercolor.g) * 0.5;
    //    color1.b = (color1.b + watercolor.b) * 0.5;
        
        
    //}
        
    
    
  
    
    //material.color = try! .init(tint: .white.withAlphaComponent(0.9999),
      //                       texture: .init(.load(named: "mat.png", in: nil)))
    
  
   
    params.surface().set_base_color(color1);
   
    
    //params.surface().set_metallic(half(0.2));
    params.surface().set_specular(0.9);
    params.surface().set_roughness(half(0.57));
    params.surface().set_clearcoat(half(1.0));
    params.surface().set_clearcoat_roughness(half(0.6));
    
   
    
    
    //params.surface().set_opacity(nnx.r); //does not seems to work
   
    
    
    
    //params.textures().emissive_color().
}

