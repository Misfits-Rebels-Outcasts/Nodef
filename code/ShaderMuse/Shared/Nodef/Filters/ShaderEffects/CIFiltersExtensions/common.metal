//
//  Copyright © 2022 James Boo. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
#include <CoreImage/CoreImage.h> // includes CIKernelMetalLib.h

extern "C" { namespace coreimage {
    
float3 noiseSamplesReverse(float2 uv,sampler sourceImage)
{
    //float2 tuv = uv;
    //uv.x = tuv.x;
    //uv.y = -tuv.y;
    
    //mirrored preat sampling
    //linear ?
    uv = abs(uv);
    uv.y = 1.0-uv.y;
    if (uv.x>1.0)
    {
        float remainder = fract(uv.x);
        int quotient = floor(uv.x);
        if (quotient%2==0)
            uv.x = remainder;
        else
            uv.x = 1.0- remainder;
            
        //uv.x=1.0-(uv.x-1.0);
    }
    if (uv.y>1.0)
    {
        float remainder = fract(uv.y);
        int quotient = floor(uv.y);
        if (quotient%2==0)
            uv.y = remainder;
        else
            uv.y = 1.0- remainder;
        
    }
    
    
    float3 sampledpixel = sourceImage.sample(uv).rgb;
    return sampledpixel;
    
}

}}
