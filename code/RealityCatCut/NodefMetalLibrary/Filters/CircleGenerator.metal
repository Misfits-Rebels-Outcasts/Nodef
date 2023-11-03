//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

#include <metal_stdlib>
#include <CoreImage/CoreImage.h>
using namespace metal;

extern "C" { namespace coreimage {
    
    float4 drawcircleFilter(sampler inputImage, sampler sampledImage, float radius, float2 loc,float4 inputColor,float4 backgroundColor) {

        float2 pos = sampledImage.coord();
        float2 sizeImage = inputImage.size();
        //float3 org = inputImage.sample(pos).rgb;
        
        float2 uv = float2(pos.x,pos.y);
        float2 p = uv-loc/sizeImage;//-0.5;
        p.x *= sizeImage.x / sizeImage.y;
        float4 color = float4(0,0,0,1);
        float relativeRadius = radius/ sizeImage.x;
        //color = mix(inputColor,float3(0,0,0),
        color = mix(inputColor,backgroundColor,
                    smoothstep(relativeRadius-0.002,
                               relativeRadius+0.002,
                               length(p)
                               )
                    );
        
        float4 ret = color; //float4(color,1.0);
        return ret;
         
    }

}}
  


