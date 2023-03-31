//
//  Copyright © 2022 James Boo. All rights reserved.
//  Original code is under the Original License
//  The modified ported derivation is available under GPL2.0
//
//  Based on Morgan McGuire @morgan3d
//  https://www.shadertoy.com/view/4dS3Wd
//
//  By Morgan McGuire @morgan3d, http://graphicscodex.com
//  Reuse permitted under the BSD license.
//  Also described on : The Book of Shaders: Fractal Brownian Motion
//  https://thebookofshaders.com/13/
//  https://www.shadertoy.com/view/llySRV

#include <metal_stdlib>
using namespace metal;


#include <CoreImage/CoreImage.h> // includes CIKernelMetalLib.h

extern "C" { namespace coreimage {
    
    /*
    extern "C" float3 noiseSamplesReverse(float2 uv,sampler sourceImage);
   
    
    float3 tSamples(float2 uv,sampler sourceImage,float sampletype=0.0)
    {
        
        //mirrored preat sampling
        //linear ?
        uv = abs(uv);
        
        if (sampletype==1.0)
        {
            float2 offset=float2(0.5,0.5);
            float scale =0.5;
            uv = scale*abs(uv)+offset;
        }
        else if (sampletype==2.0)
        {
            float2 offset=float2(0.7,0.7);
            float scale =0.3;
            uv = scale*abs(uv)+offset;
        }
        
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
    */
    
    #define NUM_OCTAVES5 5
    
    //ver 3.0
    float random32_anim04 (float2 st) {
        return fract(sin(dot(st.xy,
                             float2(12.9898,78.233)))*
            43758.5453123);
    }
   
    // Based on Morgan McGuire @morgan3d
    // https://www.shadertoy.com/view/4dS3Wd
    float noise32_anim04 (float2 st) {
        float2 i = floor(st);
        float2 f = fract(st);

        // Four corners in 2D of a tile
        float a = random32_anim04(i);
        float b = random32_anim04(i + float2(1.0, 0.0));
        float c = random32_anim04(i + float2(0.0, 1.0));
        float d = random32_anim04(i + float2(1.0, 1.0));

        float2 u = f * f * (3.0 - 2.0 * f);

        return mix(a, b, u.x) +
                (c - a)* u.y * (1.0 - u.x) +
                (d - b) * u.x * u.y;
    }

    float fbm34 ( float2 _st) {
        float v = 0.0;
        float a = 0.5;
        float2 shift = float2(100.0);
        // Rotate to reduce axial bias
        float2x2 rotate = float2x2(cos(0.5), sin(0.5),
                        -sin(0.5), cos(0.50));
        for (int i = 0; i < NUM_OCTAVES5; ++i) {
            v += a * noise32_anim04(_st);
            _st = rotate * _st * 2.0 + shift;
            a *= 0.5;
        }
        return v;
    }
    
    //ver 1.1
    float4 fBMNoise(sampler inputImage, sampler sampledImage, float animType, float inputAuraMask, float angle, float iTime,float3 inputColor, float sampletype=0.0) {

        
        //currently text / mask image have to be same size as fbm inputimage
        float2 pos = sampledImage.coord();
        float2 sizeImage = inputImage.size();
        float3 org = inputImage.sample(pos).rgb;
        
        //float3 mask = noiseSamplesReverse(pos, inputMask);
        //float3 maskExtend = noiseSamplesReverse(pos, inputMaskExtend);
    
       
     
        float2 uv = float2(pos.x,pos.y);
        float2 p = uv-0.5;
        p.x *= sizeImage.x / sizeImage.y;
      
        //Actual
        float3 color = float3(0,0,0);
        
        
        // Normalized pixel coordinates (from 0 to 1)
    
        
        float scale = 5.0;
        float u_time = iTime;
        float2 st = pos*scale;
        
           float2 q = float2(0.);
           q.x = fbm34( st + 0.00*u_time);
           q.y = fbm34( st + float2(1.0));

           float2 r = float2(0.);
           r.x = fbm34( st + 1.0*q + float2(1.7,9.2)+ 0.15*u_time );
           r.y = fbm34( st + 1.0*q + float2(8.3,2.8)+ 0.126*u_time);

           float f = fbm34(st+r);

           color = mix(float3(0.101961,0.619608,0.666667),
                       float3(0.666667,0.666667,0.498039),
                       clamp((f*f)*4.0,0.0,1.0));

           color = mix(color,
                       float3(0,0,0.164706),
                       clamp(length(q),0.0,1.0));

           color = mix(color,
                       float3(0.666667,1,1),
                       clamp(abs(r.x),0.0,1.0));

           float4 fragColor = float4((f*f*f+.6*f*f+.5*f)*color,1.);
       
       
        
        float4 ret = fragColor;
        return ret;
         
        /*
        if (inputAuraMask==0)
        {
            //1)texture in text
            float mod = mask.b;
            color*=1.0-mod;
        }
        else  if (inputAuraMask==1)
        {
            //2) simple ivory template
            //texture in text
            float modExt = maskExtend.b;
            color*=1.0-modExt;
            if (modExt>0.8)
                color = maskExtend;
                //color = org;
            
        }
        else  if (inputAuraMask==2)
        {
            
            //3)Text effects guassian blur 9 (linear sampling)
            float mod = mask.b;
            float modExt = maskExtend.b;
            color*=pow(1.0-modExt,2.3)/0.02743; //use with radius blur 27
            //color*=pow(1.0-modExt,1.2)/0.02743; //use with radius blur 12
            if (mod>0.8)
                color=mix(color,1.0-mask,0.8);
       
        }
        else  if (inputAuraMask==3)
        {
        
            //4)log version
            float mod = mask.b;
            float modExt = maskExtend.b;
             //original
            //color*=pow((1.0-modExt),2.3)/0.02743; //use with radius blur 27
            color/=pow(log2((1.0-modExt)*5.0),2.3)/0.2743;
            //color/=pow(sin((1.0-modExt)),3.3)/0.072743; //sin version
            
            if (mod>0.8)
           
                color=mix(color,pow(log2((1.0-modExt)*5.0),2.3)/0.2743,0.8);
            color = 1.0-color;
             
        }
        else  if (inputAuraMask==4)
        {
        
            //5)sin version
            float mod = mask.b;
            float modExt = maskExtend.b;
            color/=pow(sin((1.0-modExt))*0.5+0.5,3.3)/0.072743; //sin version
            
            if (mod>0.8)
                color=mix(color,pow(log2((1.0-modExt)*5.0),2.3)/0.2743,0.8);
            //color = 1.0-color;
         
        }
        else  if (inputAuraMask==5)
        {
            //6) Simple Text sdf emulate
            //need blur radius at around 7 (linear sampling)
            float modx = mask.b;
            float modExt = maskExtend.b;
            //float modshift = maskShift.b;
            //float modExtshift = maskExtendShift.b;
            //color/= modExt*modExt/0.0010; //filter into sdf shape area
            color*=0.0062/pow(modExt,4.5);
            color*=0.07053/pow(modExt,4.32);
            //color = sin(color)*0.5+0.5;
        }
        else  if (inputAuraMask==6)
        {
        
            
            //at guassian blur 12
            //7) Text sdf diff
            //need blur radius at around 9
            //float modx = mask.b;
            float modx = mask.b-maskExtend.b;
            float modExt = maskExtend.b;
            //float modshift = maskShift.b;
            //float modExtshift = maskExtendShift.b;
            //color/= modExt*modExt/0.0010; //filter into sdf shape area
            color*=0.03/pow(1.0-modx,5.0);
            color*=0.0153/pow(1.0-modx,5.32);
            if (mask.b <0.5)
                color=1.0-mask;
            
            
         
        }
        else  if (inputAuraMask==7)
        {
         
            //no mask
        }
        */
        
        
           
       
    }
    
    
  

}}
  


