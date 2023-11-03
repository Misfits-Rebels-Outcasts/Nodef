//
//  Copyright © 2022 James Boo. All rights reserved.
//

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
    
    
    //ver 3.0
   
   // Based on
   //https://www.shadertoy.com/view/WsjGRz
    
    float hash21(float2 v) {
        return fract(sin(dot(v, float2(12.9898, 78.233))) * 43758.5453123);
    }

    float noise21(float2 uv) {
        float2 f = fract(uv);
        float2 i = floor(uv);
        f = f * f * (3. - 2. * f);
        return mix(
            mix(hash21(i), hash21(i + float2(1,0)), f.x),
            mix(hash21(i + float2(0,1)), hash21(i + float2(1,1)), f.x), f.y);
    }

    float fbm21(float2 uv) {
        float freq = 2.;
        float amp = .5;
        float gain = .54;
        float v = 0.;
        for(int i = 0; i < 6; ++i) {
            v += amp * noise21(uv);
            amp *= gain;
            uv *= freq;
        }
        return v;
    }

  
    float3 basePalette21(float t) {
        return .5 + .6 * cos(6.283185 * (-t + float3(.0, .1, .2) - .2));
    }

    float3 smokePalette21(float t) {
        return float3(.6, .5, .5)
            + .5 * cos(6.283185 * (-float3(1., 1., .5) * t + float3(.2, .15, -.1) - .2));
    }

  
    
    //ver 1.1
    float4 animTex02Filter(sampler inputImage, sampler sampledImage, float animType, float inputAuraMask, float angle, float iTime,float3 inputColor, float sampletype=0.0) {

        
        //currently text / mask image have to be same size as fbm inputimage
        float2 pos = sampledImage.coord();
        float2 sizeImage = inputImage.size();
        //float3 org = inputImage.sample(pos).rgb;
        
        //float3 mask = noiseSamplesReverse(pos, inputMask);
        //float3 maskExtend = noiseSamplesReverse(pos, inputMaskExtend);
    
       
     
        float2 uv = float2(pos.x,pos.y);
        float2 p = uv-0.5;
        p.x *= sizeImage.x / sizeImage.y;
      
        //Actual
        //float3 color = float3(0,0,0);
        
        
        //n = fbmPattern21(scale * uv, q, r, iTime);
        
        float scale = 5.0;
        float3 col = float3(.1);
        float n;
        
        
        uv = scale * p;
        p = uv;
        
        float2 q;
        float2 r;
        
        float qCoef = 2.;
        float rCoef = 3.;
      
        q.x = fbm21(p             + .0  * iTime);
        q.y = fbm21(p             - .02 * iTime + float2(10., 7.36));
        r.x = fbm21(p + qCoef * q + .1  * iTime + float2(5., 3.));
        r.y = fbm21(p + qCoef * q - .07 * iTime + float2(10., 7.36));
    
        n = fbm21(p + rCoef * r + .1 * iTime);
        //
        
        float3 baseCol = basePalette21(r.x);
        float3 smokeCol = smokePalette21(n);

        col = mix(baseCol, smokeCol, pow(q.y, 1.3));

        /*
    #ifdef DEBUG_PALETTE
        float x = fragCoord.x / iResolution.x;
        col = mix(col, basePalette(x), step(abs(uv.y - .03), .02));
        col = mix(col, smokePalette(x), step(abs(uv.y - .08), .02));
    #endif
*/
  
        
        float4 ret = float4(col, 1.);
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
  


