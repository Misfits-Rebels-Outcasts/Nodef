#include <metal_stdlib>
#include <CoreImage/CoreImage.h>
using namespace metal;

extern "C" { namespace coreimage {
        
    float4 colorChannels(sampler inputImage, float rAmount, float gAmount, float bAmount, float aAmount) {
/*
        float2 pos = inputImage.coord();
        float2 sizeImage = inputImage.size();
        float3 org = inputImage.sample(pos).rgb;
        
        return float4(rAmount*org.r, gAmount*org.g, bAmount*org.b, aAmount);
 */
/*
        float2 pos = inputImage.coord();
        float4 org = unpremultiply(inputImage.sample(pos));
        org.rgb=org.bbb;
        return unpremultiply(inputImage.sample(pos));
 */
        
        float2 pos = inputImage.coord();
        float4 org = unpremultiply(inputImage.sample(pos));
        float4 r = unpremultiply(inputImage.sample(pos));
        r.rgb = r.rrr;
        r=premultiply(r);
        float4 g = unpremultiply(inputImage.sample(pos));
        g.rgb = g.ggg;
        g=premultiply(g);
        float4 b = unpremultiply(inputImage.sample(pos));
        b.rgb = b.bbb;
        b=premultiply(b);
         
        org = 0.3*r + 0.59*g + 0.11*b;
        
        return org;
         

                
    }

}}
  


