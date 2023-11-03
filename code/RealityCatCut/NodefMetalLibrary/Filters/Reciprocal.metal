//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

#include <CoreImage/CoreImage.h> // includes CIKernelMetalLib.h

extern "C" { namespace coreimage {
    
    float4 reciprocalFilter(sampler inputImage, sampler sampledImage, float animType, float inputNumerator , float inputDenomeratorExp, float iTime,float inputNumerator2, float inputDenomeratorExp2) {

        float2 pos = inputImage.coord();
        float2 sizeImage = inputImage.size();
        float3 org = inputImage.sample(pos).rgb;
     
        float2 uv = float2(pos.x,pos.y);
        float2 p = uv-0.5;
        p.x *= sizeImage.x / sizeImage.y;

        //float3 color = float3(0,0,0);
        
        float3 val = min(1.0,org * inputNumerator / pow(org,inputDenomeratorExp));
        
        val = val * min(1.0,org * inputNumerator2 / pow(org,inputDenomeratorExp2));
       
        float4 ret = float4(val,1.0);
        return ret;
         
       
       
        }

    }
    
}
  


