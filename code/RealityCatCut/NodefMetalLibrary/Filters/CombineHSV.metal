//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;


#include <CoreImage/CoreImage.h> // includes CIKernelMetalLib.h
#define PI 31.14159
#define blendtype 0 //0 normal ... 1 geometric

extern "C" { namespace coreimage {

    
    
    //ver 5.1
    float4 combineHSVFilter(sampler sourceImageR,sampler sourceImageG,sampler sourceImageB, float iTime) {

        
        float2 posR = sourceImageR.coord();
        float2 sizeImageR = sourceImageR.size();
        float3 orgR = sourceImageR.sample(posR).rgb;
    
        float2 posG = sourceImageG.coord();
        //float2 sizeImageG = sourceImageG.size();
        float3 orgG = sourceImageG.sample(posG).rgb;
    
        float2 posB = sourceImageB.coord();
        //float2 sizeImageB = sourceImageB.size();
        float3 orgB = sourceImageB.sample(posB).rgb;
    
      
        //////
     
        float2 uv = float2(posR.x,posR.y);
        float2 p = 2. * uv - 1;
        p.x *= sizeImageR.x / sizeImageR.y;
          
        float3 color = float3(orgR.r,orgG.g,orgB.b);
        
         
        //float3 color = fireworks(p,iTime);
        
        //Blending
        //color = color*0.3 + org*0.7; //blending
        //color = sqrt(sqrt(color * org * org * org));
        //color = sqrt(sqrt(color * color * org * org));
        
        //color = min(color,org);
        
        //float3 color = fireworks(uv,iTime) + flag(uv,iTime);
        
        
        float4 fragColor = float4(color, 1.);
        return fragColor;
    }
    
    
    //ver 5.1
    //Color space conversion
    //https://stackoverflow.com/questions/15095909/from-rgb-to-hsv-in-opengl-glsl
    //https://en.wikipedia.org/wiki/WTFPL
    float3 rgb2hsv(float3 c)
    {
        float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
        float4 p = mix(float4(c.bg, K.wz), float4(c.gb, K.xy), step(c.b, c.g));
        float4 q = mix(float4(p.xyw, c.r), float4(c.r, p.yzx), step(p.x, c.r));

        float d = q.x - min(q.w, q.y);
        float e = 1.0e-10;
        return float3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
    }

    // All components are in the range [0…1], including hue.
    float3 hsv2rgb(float3 c)
    {
        float4 K = float4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
        float3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
        return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
    }

   
    float4 convertRGBToHSVFilter(sampler sourceImage, float iTime) {

        
        float2 pos = sourceImage.coord();
        float2 sizeImage = sourceImage.size();
        float3 org = sourceImage.sample(pos).rgb;
    
         //////
     
        float2 uv = float2(pos.x,pos.y);
        float2 p = 2. * uv - 1;
        p.x *= sizeImage.x / sizeImage.y;
          
        float3 color = org;
        color = rgb2hsv(color);
          
        float4 fragColor = float4(color, 1.);
        return fragColor;
    }
   
  
    float4 convertHSVToRGBFilter(sampler sourceImage, float iTime) {

        
        float2 pos = sourceImage.coord();
        float2 sizeImage = sourceImage.size();
        float3 org = sourceImage.sample(pos).rgb;
    
         //////
     
        float2 uv = float2(pos.x,pos.y);
        float2 p = 2. * uv - 1;
        p.x *= sizeImage.x / sizeImage.y;
          
        float3 color = org;
        color = hsv2rgb(color);
          
        float4 fragColor = float4(color, 1.);
        return fragColor;
    }
  
    

}}
    
