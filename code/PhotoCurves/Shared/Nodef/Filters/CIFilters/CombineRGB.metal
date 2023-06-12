//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//


#include <metal_stdlib>
using namespace metal;


#include <CoreImage/CoreImage.h> // includes CIKernelMetalLib.h
#define PI 31.14159
#define blendtype 0 //0 normal ... 1 geometric

extern "C" { namespace coreimage {

    
    
    //ver 1.1
    float4 combineRGBFilter(sampler sourceImageR,sampler sourceImageG,sampler sourceImageB, float iTime, float combineMode) {

        
        float2 posR = sourceImageR.coord();
        float2 sizeImageR = sourceImageR.size();
        float3 orgR = sourceImageR.sample(posR).rgb;
    
        float2 posG = sourceImageG.coord();
        float2 sizeImageG = sourceImageG.size();
        float3 orgG = sourceImageG.sample(posG).rgb;
    
        float2 posB = sourceImageB.coord();
        float2 sizeImageB = sourceImageB.size();
        float3 orgB = sourceImageB.sample(posB).rgb;
    
      
        //////
     
        float2 uv = float2(posR.x,posR.y);
        float2 p = 2. * uv - 1;
        p.x *= sizeImageR.x / sizeImageR.y;
          
        float3 color = float3(orgR.r,orgG.g,orgB.b);
        int cm = int(combineMode);\
        if (cm==1)
        {
            //red
            color = float3(orgR.r,0.0,0.0);
        }
        else if (cm==2)
        {
            //green
            color = float3(0.0,orgG.g, 0.0);
        }
        else if (cm==3)
        {
            //green
            color = float3(0.0, 0.0, orgB.b);
        }
        else if (cm==4)
        {
            //not used
            //float3(orgR.r,orgR.g,orgR.b);
          
        }
        
        
        float4 fragColor = float4(color, 1.);
        return fragColor;
    }
    
    
  
    

}}
    
