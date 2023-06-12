//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

#include <metal_stdlib>
#include <RealityKit/RealityKit.h>
using namespace metal;
#include "helpers.h"

[[visible]]
void geometryModifier(realitykit::geometry_parameters params)
{
 
    
    float3 pos = params.geometry().model_position();
    float time = params.uniforms().time();
    float2 uv = params.geometry().uv0(); //the uv coordinates [0,0] tp [1,1] maps exactly to the 2D plane
    
    uv.y = 1.0 - uv.y; //flip the y-pos
    
    
    //Step 1 : generate fbm heightfield to produce displacement map
    //to offset the geometry of each vertex
  
    float warpType = 0.0;
    float angle = 0.0; //rotation of the heightmap
    float scale = 1.25;
    float2 animVelocity = float2( 0.12, 0.09); //used only if time does not remain constant
    float2 uvscale =uv*scale;
   
    //stationary function
    time = 0;
    
    //this produces a 4 dimensional height map, but we use only the value of the 1st dimension (i.e val.r). This is arbitrary, we can also use values of other dimensions such as val.g, val.b, val.w etc, since they are just random numbers
    
    float4 val =
    fBMheightmapx(uvscale,time ,warpType,animVelocity,angle);
    
    //using a power function / gamma function to amplify the generated value makes the terrian look higher for higher values, whike keeping the smaller values constant. This function is also used commonly in image processing to gives better contrast to an image.
    val = pow(1.7*val,2.5);
    
    
   //optional, make regions near the edge of the plane flat
    float dist = length(uv);
    if (dist>0.96)
        val = float4(0.05);
    
    
    //here , we are preparing the values for a displacement map
    //so that only the y-value (height) is modified, but not the x and z value
    //the value 0.063 is chosen by trial and error
    float3 offset = float3(0.0,0.063*val.r,0.0);
    
    //comment out the line below to see what happens when vertices are not offset
  
    //this function applies the fBM generated offset to the plane to make it uneven
    params.geometry().set_model_position_offset(offset);
    
     
}



[[visible]]
void surfaceShader(realitykit::surface_parameters params)
{
 
    
    
    float time = params.uniforms().time();
    float2 uv = params.geometry().uv0();
    uv.y = 1.0 - uv.y;

 
    //ver 5.0
    //fBMFlow(pos , sizeImage, org, iTime)
    float timefactor = 1.0;
    
    
    
    //fBMFlow is an extension of fBMheightmapx
    //It includes function to assign colors to the heightmap according to different coloring schemes. The set of colors (palette) used can make the generated effect change drammatically. e.g using a yellow to red spectrum can produces a fire-like effect, using a
    //blue and white palette will produces cloud-like effect
    
    //fBMFlow other extensions includes experimenting with different base noise or modifying the base noise with abs to give cloud-like or fire-like effect
    
    //stationary wave for terrian (for water wave, this paramater will vary)
    time = 0;
    
    //this funciton is mainly used for generating colors (red-brownish) for the terrain
    float4 val = fBMFlow(uv, float2(2048,2048), float3(0,0,0), time*timefactor);
   
   
    //ver 5.1
   
   
    
    float warpType = 0.0;
    float angle = 0.0;
    float scale = 1.25;
    float2 animVelocity = float2( 0.12, 0.09);
    float2 uvscale =uv*scale;
    
    float divfactor = 4.0;
    float screensize = 2048;
    
    //Note : Alternative to fBMFlow coloring scheme
    //comment out the fBMFlow line above , and uncomment the fBMFlow below
  
    //time = 0;
    //float4 val = fBMFlow(uv, float2(2048,2048), float3(0,0,0), time*timefactor, 210,1.0,1.0);
   
    
    //time = 0;
    //float valz =
    //fBMheightmapx(uv,time ,warpType,animVelocity,angle);
    //float3 val = smoothstep(float3(0.2,0.9,0.5), float3(0.8,0.40,0.3), valz);
  
   
    
    //Normals
    //setting the normal is the main item that changes the terrian from a simple surface
    //to a natural looking one
    
    //the computeNormal function is derived from the fBMheightmapx function
    
    //the fBMheightmapx function generates a heightfield (i,e produces a z-value from xy coordinates)
    //in the shader the xy coordinates is normalized (scaled into [0,0] to [1,1]) and renamed as uv
    
    //this heightfield has a normal at each uv coordinate position pointing away perpendicularly form the surfcae
    
    //the normals is computed by offseting the heightmap a little in the x-direction and a little in the y-direction to compute the difference. The normals computed thus does not necessary has magnitude / length of 1.
    
    //the normal has to be further normalized (make into length 1) for rendering purpose
    
    //stationary wave for terrian
    time = 0;
    
    float3 normal = computeNormal(uvscale,time*timefactor/divfactor ,warpType,animVelocity,angle,screensize);
    
    //normal.xy *= 3.0;
    normal = normalize(normal);
    
    
    half3 color1 = half3(0.5,0.7,0.9);
    
    half halfr = val.r;
    half halfg = val.g;
    half halfb = val.b;
    
    //asign the color generated by fBMFlow as the diffuse color of the surface / plane
    color1 = half3(halfr,halfg,halfb);
 
    
    
    
    //Step 2 : set normals using normals computed from the same fbm heightmap
    //comment out this lien to see what happens when the normal is not set
    params.surface().set_normal(normal); //set tangent space normal
    
    
    //Step 3 : color the surface with another fBM-like function named fBMFlow
    //fBMFlow simply assign colors to the terrain
   
    //comment out the line below to see what happens when base diffuse color is not set
    
    //this is the diffuse color (lit by external light source) of the surface
    params.surface().set_base_color(color1);
   
    
    //params.surface().set_metallic(half(0.2));
    params.surface().set_roughness(half(0.57));
    params.surface().set_clearcoat(half(1.0));
    params.surface().set_clearcoat_roughness(half(0.6));
    
   
    
  
     
}

