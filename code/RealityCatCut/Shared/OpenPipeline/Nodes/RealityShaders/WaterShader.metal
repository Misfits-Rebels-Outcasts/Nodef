//
//  WaterShader.metal
//  arsimplesea
//
//  Created by TechnoRiver on 06/05/2023.
//


#include <metal_stdlib>
#include <RealityKit/RealityKit.h>
using namespace metal;
#include "helpers.h"

[[visible]]
void geometryWaterModifier(realitykit::geometry_parameters params)
{
    
    //float3 pos = params.geometry().model_position();
    float time = params.uniforms().time();


    float2 uv = params.geometry().uv0();
    uv.y = 1.0 - uv.y;
    
    
    //not using at the moment
    
    
    //step 1 : generate fbm toproduce displacement map
    //to offset the geometry of each vertex
  
    float timefactor = 1.2;
    float warpType = 0.0;
    float angle = 0.0;
    float scale = 1.25;
    float2 animVelocity = float2( 0.12, 0.09);
    float2 uvscale =uv*scale;
    
    float divfactor = 1.0;
    //float screensize = 2048;
   
    //time = 0;
    float4 val =
    fBMheightmapx(uvscale,time*timefactor/divfactor ,warpType,animVelocity,angle);
    //val = pow(1.6*val,2.3);
    val = pow(1.7*val,2.1);
    
    
    //variations
    //time = 0;
    //float4 val = fBMFlow(uv, float2(1024,1024), float3(0,0,0), time*3);
   
    
    //displacement map will not work well if plane is low resolution
    float3 offset = float3(0.0,0.05*val.r,0.0);
    params.geometry().set_model_position_offset(offset);
    
    
    //params.geometry().set_model_position_offset(params.geometry().normal() *0.03*val.xyz);
    
     
}



[[visible]]
void surfaceWaterShader(realitykit::surface_parameters params)
{
    
    
    float time = params.uniforms().time();

    float2 uv = params.geometry().uv0();
    uv.y = 1.0 - uv.y;


    //half3 color = (half3)params.material_constants().base_color_tint(); // for base color (tint)
    
    //ver 5.0
    //fBMFlow(pos , sizeImage, org, iTime)
    float timefactor = 1.0;
    
    //motion wave
    //time = 0;
    float4 val = fBMFlow(uv, float2(2048,2048), float3(0,0,0), time*timefactor,112,3.0,3.0);
    
    
    //ver 5.1
    float warpType = 0.0;
    float angle = 0.0;
    float scale = 1.25;
    float2 animVelocity = float2( 0.12, 0.09);
    float2 uvscale =uv*scale;
    
    float divfactor = 4.0;
    float screensize = 2048;
    
   
    float3 normal = computeNormal(uvscale,time*timefactor/divfactor ,warpType,animVelocity,angle,screensize);
    
    //ver 5.01
    //float4 val =
    //fBMheightmapx(uvscale,time*timefactor/divfactor ,warpType,animVelocity,angle);
   
    
    /*
    //half3 color1 = half3(1,1,1);
    half3 color1 = half3(0.5,0.7,0.9);
    half3 color2 = half3(0.9,0.8,0.9);
   
    
    half halfr = val.r;
    half halfg = val.g;
    half halfb = val.b;
    */
    
    half3 color1 = half3(val.r,val.g,val.b);
    
 
    
    
    //ver 5.1

    normal = normalize(normal);
    //normal.xy *= 3.0;
    //normal = normalize(normal);
    
    
    //step 2 : set normals using normals computed from the same fbm heightmap
    params.surface().set_normal(normal); //set tangent space normal
    
   
    //params.surface().set_opacity(0.5); //not working
    //params.surface().set_ambient_occlusion(val.w);
   
    
    
    //material.color = try! .init(tint: .white.withAlphaComponent(0.9999),
      //                       texture: .init(.load(named: "mat.png", in: nil)))
    
  
    /*
    params.surface().set_base_color(color1);
    params.surface().set_specular(0.9);
    params.surface().set_metallic(half(0.3));
    params.surface().set_roughness(half(0.67));
    params.surface().set_clearcoat(half(1.0));
    params.surface().set_clearcoat_roughness(half(0.7));
    */
   
    
    params.surface().set_base_color(color1);
    params.surface().set_specular(0.9);
  
    //params.surface().set_metallic(half(0.3));
    params.surface().set_roughness(half(0.67));
    params.surface().set_clearcoat(half(1.0));
    params.surface().set_clearcoat_roughness(half(0.7));
   
    
    params.surface().set_opacity(0.7);

    
    
    

     
}

//constexpr sampler textureSampler(coord::normalized, address::repeat, filter::linear, mip_filter::linear);

[[visible]]
void surfaceWaterShader1(realitykit::surface_parameters params)
{
    
    
    float time = params.uniforms().time();

    float2 uv = params.geometry().uv0();
    uv.y = 1.0 - uv.y;


    
    //half3 color = (half3)params.material_constants().base_color_tint(); // for base color (tint)
    
    //ver 5.0
    //fBMFlow(pos , sizeImage, org, iTime)
    float timefactor = 1.0;
    
    //motion wave
    //time = 0;
    float4 val = fBMFlow(uv, float2(2048,2048), float3(0,0,0), time*timefactor,112,3.0,3.0);
    
    
    //ver 5.1
    float warpType = 0.0;
    float angle = 0.0;
    float scale = 1.25;
    float2 animVelocity = float2( 0.12, 0.09);
    float2 uvscale =uv*scale;
    
    float divfactor = 4.0;
    float screensize = 2048;
    
   
    float3 normal = computeNormal(uvscale,time*timefactor/divfactor ,warpType,animVelocity,angle,screensize);
    
    //ver 5.01
    //float4 val =
    //fBMheightmapx(uvscale,time*timefactor/divfactor ,warpType,animVelocity,angle);
   
    
    /*
    //half3 color1 = half3(1,1,1);
    half3 color1 = half3(0.5,0.7,0.9);
    half3 color2 = half3(0.9,0.8,0.9);
   
    
    half halfr = val.r;
    half halfg = val.g;
    half halfb = val.b;
    */
    
    half3 color1 = half3(val.r,val.g,val.b);
    
 
    
    
    //ver 5.1

    normal = normalize(normal);
    //normal.xy *= 3.0;
    //normal = normalize(normal);
    
    
    //step 2 : set normals using normals computed from the same fbm heightmap
    //params.surface().set_normal(normal); //set tangent space normal
    
   
    //params.surface().set_opacity(0.5); //not working
    //params.surface().set_ambient_occlusion(val.w);
   
    
    
    //material.color = try! .init(tint: .white.withAlphaComponent(0.9999),
      //                       texture: .init(.load(named: "mat.png", in: nil)))
    
  
    /*
    params.surface().set_base_color(color1);
    params.surface().set_specular(0.9);
    params.surface().set_metallic(half(0.3));
    params.surface().set_roughness(half(0.67));
    params.surface().set_clearcoat(half(1.0));
    params.surface().set_clearcoat_roughness(half(0.7));
    */
   /*
    half3 baseColorTint = (half3)params.material_constants().base_color_tint();
    auto tex = params.textures();
    half3 color = (half3)tex.base_color().sample(textureSampler, uv).rgb;
    color *= baseColorTint;
    half3 color2 = half3(val.r*color.r,val.g*color.g,val.b*color.b);
    params.surface().set_base_color(color);
*/
    
    params.surface().set_base_color(color1);
    params.surface().set_specular(0.9);
  
    //params.surface().set_metallic(half(0.3));
    params.surface().set_roughness(half(0.67));
    params.surface().set_clearcoat(half(1.0));
    params.surface().set_clearcoat_roughness(half(0.7));
   
    
    params.surface().set_opacity(0.7);

    
    
    

     
}

[[visible]]
void surfaceWaterShaderEmpty(realitykit::surface_parameters params)
{
    
     
}


[[visible]]
void geometryWaterModifier1(realitykit::geometry_parameters params)
{
    
    //float3 pos = params.geometry().model_position();
    float time = params.uniforms().time();


    float2 uv = params.geometry().uv0();
    uv.y = 1.0 - uv.y;
    
    
    //not using at the moment
    
    
    //step 1 : generate fbm toproduce displacement map
    //to offset the geometry of each vertex
  
    float timefactor = 1.2;
    float warpType = 0.0;
    float angle = 0.0;
    float scale = 1.25;
    float2 animVelocity = float2( 0.12, 0.09);
    float2 uvscale =uv*scale;
    
    float divfactor = 1.0;
    //float screensize = 2048;
   
    //time = 0;
    float4 val =
    fBMheightmapx(uvscale,time*timefactor/divfactor ,warpType,animVelocity,angle);
    //val = pow(1.6*val,2.3);
    val = pow(1.7*val,2.1);
    
    
    //variations
    //time = 0;
    //float4 val = fBMFlow(uv, float2(1024,1024), float3(0,0,0), time*3);
   
    
    //displacement map will not work well if plane is low resolution
    //float3 offset = float3(0.0,0.05*val.r,0.0);
    //params.geometry().set_model_position_offset(offset);
    
    
    //params.geometry().set_model_position_offset(params.geometry().normal() *0.03*val.xyz);
    
     
}
[[visible]]
void geometryWaterModifier2(realitykit::geometry_parameters params)
{
    float3 pos = params.geometry().model_position();
    // x axis: wave length = 0.2 [m], cycle = 8.0 [sec]
    // z axis: wave length = 0.3 [m], cycle = 10.0 [sec]
    // wave height = +/- 0.005 [m]
    float3 offset = float3(0.0,
                           cos( 3.14 * 2.0 * pos.x / 0.2 + 3.14 * 2.0 * params.uniforms().time() / 8.0 )
                         * cos( 3.14 * 2.0 * pos.z / 0.3 + 3.14 * 2.0 * params.uniforms().time() / 10.0 ) * 0.005,
                           0.0);
    params.geometry().set_model_position_offset(offset);
}
