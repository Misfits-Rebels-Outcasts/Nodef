//
//  Copyright © 2022 James Boo. All rights reserved.
//

//https://www.shadertoy.com/view/ftV3D1
//Based on :Motion portals


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
    
    #define NUM_OCTAVES32 10
    
    //ver 3.0
    float random32 (float2 st) {
        return fract(sin(dot(st.xy,
                             float2(12.9898,78.233)))*
            43758.5453123);
    }
   
    // Based on Morgan McGuire @morgan3d
    // https://www.shadertoy.com/view/4dS3Wd
    float noise32 (float2 st) {
        float2 i = floor(st);
        float2 f = fract(st);

        // Four corners in 2D of a tile
        float a = random32(i);
        float b = random32(i + float2(1.0, 0.0));
        float c = random32(i + float2(0.0, 1.0));
        float d = random32(i + float2(1.0, 1.0));

        float2 u = f * f * (3.0 - 2.0 * f);

        return mix(a, b, u.x) +
                (c - a)* u.y * (1.0 - u.x) +
                (d - b) * u.x * u.y;
    }

    float box (float2 _size, float2 _uv){
        _size = float2(0.5) - _size*.5;
        float2 st = smoothstep (_size, _size+float2(0.24), _uv);
        st *= smoothstep (_size, _size+float2(0.24),float2(1.0)-_uv);
        float box = st.x * st.y;
        return box;
    }

    
    float fbm32( float2 _st, float iTime) {
        float v = 0.0;
        float a = 0.55;
        float2 shift = float2(10.0);
        // Rotate to reduce axial bias
        float2x2 rot = float2x2(cos(0.001 * iTime), tan(0.005),
                        -sin(0.005), cos(0.001 * iTime));
        for (int i = 0; i < NUM_OCTAVES32; ++i) {
            v += a * noise32(_st);
            _st = rot * _st * 2.0 + shift;
            a *= 0.5;
        }
        return v;
    }

    
    //ver 1.1
    float4 animTex03Filter(sampler inputImage, sampler sampledImage, float animType, float inputAuraMask, float angle, float iTime,float3 inputColor, float sampletype=0.0) {

        
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
        float3 color = float3(0,0,0);
        
        
        // Normalized pixel coordinates (from 0 to 1)
    
         float2 uva = float2(fbm32(uv,iTime));
         float grid = sin(uva.x * 100.) * sin(uva.y * 100.);
           grid = step(.995,grid);

        
          //float3 col = float3(0.0);
          float2 q = float2(0.);
           q.x = fbm32( uv + 0.110*(iTime+100.),iTime);
           q.y = fbm32( uv + float2(1.0),iTime);

           float2 r = float2(0.);
           r.x = fbm32( uv + 20.0*q + float2(1.7,9.2)+ 0.15*(iTime+100.),iTime);
           r.y = fbm32( uv + 10.0*q + float2(8.3,2.8)+ 0.126*(iTime+100.),iTime);

           float f = fbm32(uv+r*r,iTime);
           
           color = float3(grid) * 0.25;

           color -= mix(float3(0.801961 * abs(cos(iTime * .3)),0.619608 * abs(cos(iTime * .5)),0.666667),
                       float3(0.966667 * abs(sin(iTime * .4)),0.966667 * abs(cos(iTime * .2)),0.998039),
                       clamp((f*f)*4.0,0.0,1.0));

           color = mix(color,
                       float3(0,0,0.164706),
                       clamp(length(q),0.0,1.0));

           //color = mix(color,
             //          float3(0.966667,1,1),
              //         clamp(length(r.x),0.0,1.0));
            color = mix(color,
                    float3(0.966667,1,1),
                    clamp(abs(r.x),0.0,1.0));
                               
                             
                             
           color /= box(float2(.2  * abs(sin(iTime * .3)) + .5,1.), uv - float2(.395, 0.)) * float3(.7,1.,1.) +
                    box(float2(.2  * abs(sin(iTime * .2)) + .5,1.), uv + float2(.2, 0.)) * float3(1.,.8,.9) +
                    box(float2(.2 * abs(sin(iTime * .1)) + .5,1.), uv - float2(.98, 0.))  * float3(1.,1.,1.);

           // Output to screen
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
  


