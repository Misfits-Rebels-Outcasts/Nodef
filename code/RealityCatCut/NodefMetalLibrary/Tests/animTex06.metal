//
//  Copyright © 2022 James Boo. All rights reserved.
//



// Ether by nimitz 2014 (twitter: @stormoid)
// https://www.shadertoy.com/view/MsjSW3


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
    float2x2 rotateMatrix70(float theta)
    {
        float c = cos(theta);
        float s = sin(theta);
        return float2x2(c,-s,s,c);
        
    }
    
    float map70(float3 p,float t){
        p.xz = p.xz * rotateMatrix70(t*0.4);
        p.xy = p.xy * rotateMatrix70(t*0.3);
        float3 q = p*2.+t;
        return length(p+float3(sin(t*0.7)))*log(length(p)+1.) + sin(q.x+sin(q.z+sin(q.y)))*0.5 - 1.;
    }
    
    
    //ver 1.1
    float4 animTex06Filter(sampler inputImage, sampler sampledImage, float animType, float inputAuraMask, float angle, float iTime,float3 inputColor, float sampletype=0.0) {

        
        //currently text / mask image have to be same size as fbm inputimage
        float2 pos = sampledImage.coord();
        float2 sizeImage = inputImage.size();
        //float3 org = inputImage.sample(pos).rgb;
        
        //float3 mask = noiseSamplesReverse(pos, inputMask);
        //float3 maskExtend = noiseSamplesReverse(pos, inputMaskExtend);
    
        
        /*
        float2 uv = float2(pos.x,pos.y);
        float2 p = uv-0.5;
        //float2 p = uv;
        p.x *= sizeImage.x / sizeImage.y;
      */
        //Actual
        //float3 color = float3(0,0,0);
        
        
        //vec2 p = fragCoord.xy/iResolution.y - vec2(.9,.5);
        float2 p = pos*sizeImage/sizeImage.y - float2(.9,.5);
       
        float3 cl = float3(0.);
        float d = 2.5;
            for(int i=0; i<=5; i++)    {
                float3 vvz = float3(p.x, p.y, -1.0);
                float3 p = float3(0,0,5.) + normalize(vvz)*d;
                float rz = map70(p,iTime);
                float f =  clamp((rz - map70(p+.1,iTime))*0.5, -.1, 1. );
                float3 l = float3(0.1,0.3,.4) + float3(5., 2.5, 3.)*f;
                cl = cl*l + smoothstep(2.5, .0, rz)*.7*l;
                d += min(rz, 1.);
        }
         
        float4   fragColor = float4(cl, 1.);
        
       
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
  


