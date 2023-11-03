//
//  Copyright © 2022 James Boo. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

#include <CoreImage/CoreImage.h> // includes CIKernelMetalLib.h

float2x2 rotateMatrix(float theta)
{
    float c = cos(theta);
    float s = sin(theta);
    return float2x2(c,-s,s,c);
    
}

float2x2 rotateBasic()
{
    
    return float2x2(0.866, 0.54, -0.54, 0.866);
   
}


//periodic
float pdf(float2 p)
{
    float val = abs(atan(p.y*0.9543))*(cos(p.x*0.9532)+sinh(p.y*0.9816));
    return val;
}


//periodic
float pdf2(float2 p)
{
    float val = length(p)*(cos(p.y/p.x*0.9532)+sinh(p.y*0.9816));
    return val;
}

extern "C" { namespace coreimage {
    
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

    
    //val 0 to 1, inverse return 1 to 0
    float3 reciprocalinvert(float3 r)
    {
            return 2.0*(1-1/(2.0-r));
           //return 1.0-2.0*(1-1/(2.0-r));
           
    }
   
    
    //ver 2.0
    //60 deg ok
    float3 turbulance_p(float2 pos,float t,sampler sourceImage,float direction_deg=0.0, float expon=0.9, float strength = 0.5, float layerscale = 0.1356, float layervelocity = 0.132135,
                            float sampletype=0.0)
    {
            float amplitude=2.273;
            float2 newpos = pos;
            float3 val = 0.0;
            float2x2 rMatrix = rotateBasic()*rotateMatrix(direction_deg*3.14159/180.0);
        
            for (float i= 1.0;i <24.0;i++ )
            {
                    newpos+= t*0.23;
                    float distribution1 = pdf(pos*2.-t*0.1);
                    float distribution2 = pdf(pos*2.5+3.43-t*0.12);
                    float2  layer = float2(distribution1,distribution2)*0.13;
                    layer = layer * layerscale * (1.0 / pow(dot(layer,layer),0.54513));
                    
                    layer*=rotateMatrix((pos.x*1.2+pos.y*0.9)*.2953+t*12.2353);
                    pos += layer*layervelocity;
                    
                    
                    val+= (sin(tSamples(pos,sourceImage,sampletype)*1.0)*0.5+0.1) /(pow(amplitude,expon));
                
                
                    
                    float2 adv = (newpos - pos)*strength;
                    pos = pos + adv;
                    
                    amplitude *= 1.5;
                    pos *= 1.4; //scale
                    newpos *= 1.35; //newpos scale
                   
                    pos *=rMatrix; //rotate
                    newpos *=rMatrix; //newpos rotate
            }
            
            //val = reciprocalinvert(val);
            
            return val;
    }

    //ver 1.1
    float4 fractalFlowNoise(sampler inputImage, sampler sampledImage,sampler inputMask, sampler inputMaskExtend, float animType, float inputAuraMask, float angle, float iTime,float3 inputColor,float2 initcolormod,float2 initlocation ,float2 vscaling, float inputBlend, float invertmask,float direction_deg=0.0, float expon=0.9, float strength = 0.5, float layerscale = 0.1356, float layervelocity = 0.132135,float sampletype=0.0) {

        
        //currently text / mask image have to be same size as fbm inputimage
        float2 pos = sampledImage.coord();
        float2 sizeImage = inputImage.size();
        float3 org = inputImage.sample(pos).rgb;
        
        float3 mask = noiseSamplesReverse(pos, inputMask);
        float3 maskExtend = noiseSamplesReverse(pos, inputMaskExtend);
    
        if (invertmask==0)
        {
        }
        else  if (invertmask==1)
        {
            mask = 1.0-mask;
            maskExtend = 1.0- maskExtend;
           
        }
        else  if (invertmask==2)
        {
            mask = reciprocalinvert(mask);
            maskExtend = reciprocalinvert(maskExtend);
            
        }
        
        
        
        //return float4(mask,1.0);
        
        
        //////
        //constexpr sampler s(filter::linear, mip_filter::linear);
        //sampler samplefilter(mip_filter::linear);
     
        float2 uv = float2(pos.x,pos.y);
        
         
        float2 p = uv-0.5;
        p.x *= sizeImage.x / sizeImage.y;
        p*= 3.;
        
      
        //float2x2 m2 = rotateMatrix(sin(iTime*1.0));
       
        float3 color = float3(0,0,0);
         
        if (animType==4)
        {
            //darker images
            //color = turbulance_p(p,iTime,sampledImage);
            color = turbulance_p(p,iTime,sampledImage, direction_deg, expon, strength, layerscale, layervelocity ,sampletype);
            
           
            color = smoothstep(0.0,0.63,sin(color)); //gives better color contrast
            float3 orgcolor = color;
            float3 lightvector = float3(0.5,2.3,-1.4);
            lightvector = normalize(lightvector);
            color = normalize(color);
            //float3 ncolor= color;
            color = dot(lightvector,color);
            
            //float3 dotcolor = color;
            color = mix(float3(.117,0.072,0.011),float3(.5,0.8,1.0),color);
            color = abs(mix(orgcolor,color,0.3)*2.0-1.0);
            color = smoothstep(0.0,0.43,sin(color)); //gives better color contrast
            
           
           
            
        }
        else if (animType==5)
        {
            //darker images
            //color = turbulance_p(p,iTime,sampledImage);
            color = turbulance_p(p,iTime,sampledImage, direction_deg, expon, strength, layerscale, layervelocity ,sampletype);
            
            color = smoothstep(0.0,0.63,sin(color)); //gives better color contrast
            float3 orgcolor = color;
            float3 lightvector = float3(0.5,2.3,-1.4);
            lightvector = normalize(lightvector);
            color = normalize(color);
            //float3 ncolor= color;
            color = dot(lightvector,color);
            //float3 dotcolor = color;
            
            color = mix(float3(.15,0.06,0.008),float3(.5,0.8,1.0),color);
            
            color = abs(mix(orgcolor,color,0.3)*2.0-1.0);
            color = smoothstep(0.0,0.43,sin(color)); //gives better color contrast
            
            color = dot(lightvector,color);
            
            color = pow(abs(inputColor/color),0.7);
            
            //color = 1.0-color;
            //color = abs(orgcolor/pow(color,0.5));
            
        }
       
      
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
            //float modx = mask.b;
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
            //float modExt = maskExtend.b;
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
        
       
        
        
        
        //for vegetation
        
        //try zooming..
        
        //mask effect 2 and 5
        //mask 2 refquires very small radius for blur and blurOrg ~ 0
        //color = sqrt(sqrt(org*org*org*color)); //workable wirth adjustale weights for type 5
        
        if (inputBlend==0)
        {
                
        }
        else if (inputBlend==1)
        {
            color = mix(org,color,0.7);
        }
        else if (inputBlend==2)
        {
            color = mix(org,color,0.3);
        }
        else if (inputBlend==3)
        {
            color = sqrt(sqrt(org*org*org*color));
            //color = mix(org,color,0.7);
            //color = pow(org,4.0)*pow(color,1.0/4.0);
        }
        else if (inputBlend==4)
        {
            color = pow(org,2.0)*pow(color,1.0/2.0);
        }
        
        
        float4 ret = float4(color, 1.);
        return ret;
    }
    
    
  

}}
  


