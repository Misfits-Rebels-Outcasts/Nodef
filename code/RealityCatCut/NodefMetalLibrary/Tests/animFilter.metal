//
//  Copyright © 2022 James Boo. All rights reserved.
//
#include <metal_stdlib>
using namespace metal;


#include <CoreImage/CoreImage.h> // includes CIKernelMetalLib.h
#define PI 3.1416
#define blendtype 0 //0 normal ... 1 geometric

//extern "C" float2x2 rotateMatrix(float theta);
//extern "C" float2x2 rotateBasic();


extern "C" { namespace coreimage {

    
    
    //Flow
    
    float2x2 rotateMatrix(float theta)
    {   float c = cos(theta);
        float s = sin(theta);
        return float2x2(c,-s,s,c);}
    
    float2x2 rotateBasic()
    {
        
        return float2x2( 0.80,  0.60, -0.60,  0.80 );
    }
     
    
    float grid(float2 p)
    {
        float s = sin(p.x)*cos(p.y);
        return s;
    }
    
    float grid2(float2 p)
    {
        float s = (cos(p.x)+sin(p.y))*abs(atan(p.y));
        return s;
    }

  
    
    
    
    
    
    //ver 2.0
    float3 noiseSample(float2 uv,sampler sourceImage)
    {
        
        //mirrored preat sampling
        //linear ?
        uv = abs(uv);
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
    
    float3 flowsample(float2 p,float time,sampler sourceImage)
    {
        float z=2.;
        float3 rz = 0.;
        float2 bp = p;
        float2x2 m2 = rotateBasic();
        for (float i= 1.;i <7.;i++ )
        {
            //bp += time*1.5;
            bp += time*0.2;
            float2 gr = float2(grid(p*3.-time*0.1),grid(p*3.+4.-time*0.1))*0.4;
            gr = normalize(gr)*0.4;
            
            gr*=rotateMatrix((p.x+p.y)*.3+time*10.);
            //gr *= makem2((p.x+p.y)*.3+time*10.);
            //if (i>1.0)
            p += gr*0.5;
            
            //float3 retx = noiseSample(p,sourceImage);
            
            rz+= (sin(noiseSample(p,sourceImage)*4.)*0.5+0.1) /z;
            //rz+= (sin(noiseSample(p,sourceImage)*8.)*0.5+0.5) /z;
            
            
            //moving sands..the /z
            //rz+= (sin(noise(p)*8.)*0.5+0.5) /z;
            
            p = mix(bp,p,.5);
            z *= 1.7;
            p *= 2.5;
            p*=m2;
            bp *= 2.5;
            bp*=m2;
        }
        return rz;
    }
     

    
    float3 flowsamplemod2(float2 p,float time,sampler sourceImage)
    {
        float z=2.;
        float3 rz = 0.;
        float2 bp = p;
        float2x2 m2 = rotateBasic();
        for (float i= 1.;i <24.;i++ )
        {
            //bp += time*1.5;
            bp += time*0.23;
            float2 gr = float2(grid(p*2.-time*0.1),grid(p*2.5+3.43-time*0.12))*0.13;
            gr = normalize(gr)*0.1356;
            
            gr*=rotateMatrix((p.x+p.y)*.3+time*10.);
            //gr *= makem2((p.x+p.y)*.3+time*10.);
            //if (i>1.0)
            p += gr*0.132135;
            
            //float3 retx = noiseSample(p,sourceImage);
            
            rz+= (sin(noiseSample(p,sourceImage)*1.0)*0.5+0.1) /(pow(z,0.9));
            //rz+= (sin(noiseSample(p,sourceImage)*8.)*0.5+0.5) /z;
            
            
            //moving sands..the /z
            //rz+= (sin(noise(p)*8.)*0.5+0.5) /z;
            
            p = mix(bp,p,.5);
            z *= 1.5;
            p *= 1.4;
            p*=m2;
            bp *= 1.35;
            bp*=m2;
        }
        return rz;
    }
    
   
    
     float3 flowsamplemod(float2 p,float time,sampler sourceImage)
     {
         float z=2.;
         float3 rz = 0.;
         float2 bp = p;
         float2x2 m2 = rotateBasic();
         for (float i= 1.;i <12.;i++ )
         {
             //bp += time*1.5;
             bp += time*0.2;
             float2 gr = float2(grid(p*3.-time*0.1),grid(p*3.+4.-time*0.1))*0.2;
             gr = normalize(gr)*0.2;
             
             gr*=rotateMatrix((p.x+p.y)*.3+time*10.);
             //gr *= makem2((p.x+p.y)*.3+time*10.);
             //if (i>1.0)
             p += gr*sqrt(0.5);
             
             //float3 retx = noiseSample(p,sourceImage);
             
             rz+= (sin(noiseSample(p,sourceImage)*2.0)*0.5+0.1) /(z*sqrt(z));
             //rz+= (sin(noiseSample(p,sourceImage)*8.)*0.5+0.5) /z;
             
             
             //moving sands..the /z
             //rz+= (sin(noise(p)*8.)*0.5+0.5) /z;
             
             p = mix(bp,p,.5);
             z *= sqrt(1.7);
             p *= sqrt(2.5);
             p*=m2;
             bp *= sqrt(2.5);
             bp*=m2;
         }
         return rz;
     }
    
     
     
    
    float dot2( float2 v ) { return dot(v,v); }
    
  
    //ver 1.1
    float4 animFilter(sampler inputImage, sampler sampledImage,float animType, float factor, float angle, float iTime,float2 initvelocity,float2 initcolormod,float2 initlocation ,float2 vscaling) {

        
        float2 pos = sampledImage.coord();
        float2 sizeImage = inputImage.size();
        //float3 org = inputImage.sample(pos).rgb;
        //iTime += 0.73425;
        //////
        //constexpr sampler s(filter::linear, mip_filter::linear);
        //sampler samplefilter(mip_filter::linear);
     
        float2 uv = float2(pos.x,pos.y);
        
        //float2 p = 2. * uv - 1;
        //p.x *= sizeImage.x / sizeImage.y;
        
        float2 p = uv-0.5;
        p.x *= sizeImage.x / sizeImage.y;
        p*= 3.;
        
      
        //float2x2 m2 = rotateMatrix(sin(iTime*1.0));
       
        
        
        float3 color = float3(0,0,0);
        //float3 color2 = float3(0,0,0);
        //float3 color3 = float3(0,0,0);
        
        //color = sampledpixel;
        
        
        //color = flow(p,iTime);
        //color = floworg(p,iTime);
        
        p= uv;
        //p= uv/1.2;
        //p = p - 3.0;
       
        //p.x = p.x + floworg(p,iTime+0.7234)*0.05;
        //p.y = p.y + flow(p,iTime+1.33234)*0.05;
        //p = normalize(p);
        //color = noiseSample(p,sampledImage);
        
        
        //try 2 images flow .. merging..
        animType=4;
        if (animType==0)
        {
            color = flowsample(p,iTime,sampledImage);
            color = smoothstep(0.0,0.69,sin(color)); //gives better color contrast
            // color = abs(color*2.0-1.0);
            //color = 1.0-color;
        
        }
        else if (animType==1)
        {
            color = flowsamplemod(p,iTime,sampledImage);
            color = smoothstep(0.0,0.69,sin(color)); //gives better color contrast
            color = abs((color*2.0-1.0)); //gives artistic effect...
        }
        else if (animType==2)
        {
            //darker images
            color = flowsample(p,iTime,sampledImage);
            color = smoothstep(0.0,0.69,sin(color)); //gives better color contrast
            float3 orgcolor = color;
            float3 lightvector = float3(0.5,2.3,-1.4);
            lightvector = normalize(lightvector);
            color = normalize(color);
            //float3 ncolor= color;
            color = dot(lightvector,color);
            //float3 dotcolor = color;
            color = mix(float3(.12,0.07,0.01),float3(.5,0.8,1.0),color);
            color = abs(mix(orgcolor,color,0.3)*2.0-1.0);
            
        }
        else if (animType==3)
        {
            //darker images
            color = flowsamplemod(p,iTime,sampledImage);
            color = smoothstep(0.0,0.63,sin(color)); //gives better color contrast
            //color = abs((color*2.0-1.0)); //gives artistic effect...
            float3 orgcolor = color;
            float3 lightvector = float3(0.5,2.3,-1.4);
            lightvector = normalize(lightvector);
            color = normalize(color);
            //float3 ncolor= color;
            color = dot(lightvector,color);
            //float3 dotcolor = color;
            color = mix(float3(.12,0.07,0.01),float3(.5,0.8,1.0),color);
            color = abs(mix(orgcolor,color,0.3)*2.0-1.0);
            
        }
        else if (animType==4)
        {
            //darker images
            color = flowsamplemod2(p,iTime,sampledImage);
            color = smoothstep(0.0,0.63,sin(color)); //gives better color contrast
            //color = abs((color*2.0-1.0)); //gives artistic effect...
            float3 orgcolor = color;
            float3 lightvector = float3(0.5,2.3,-1.4);
            lightvector = normalize(lightvector);
            color = normalize(color);
            //float3 ncolor= color;
            color = dot(lightvector,color);
            //float3 dotcolor = color;
            color = mix(float3(.12,0.07,0.01),float3(.5,0.8,1.0),color);
            color = abs(mix(orgcolor,color,0.3)*2.0-1.0);
            color = smoothstep(0.0,0.43,sin(color)); //gives better color contrast
            
            //color = dot(lightvector,color);
            //color = pow(abs(float3(.2,0.07,0.01)/color),0.7);
            //color = abs(orgcolor/pow(color,0.5));
            
           
            
        }
        else if (animType==5)
        {
            //darker images
            color = flowsamplemod2(p,iTime,sampledImage);
            color = smoothstep(0.0,0.63,sin(color)); //gives better color contrast
            //color = abs((color*2.0-1.0)); //gives artistic effect...
            float3 orgcolor = color;
            float3 lightvector = float3(0.5,2.3,-1.4);
            lightvector = normalize(lightvector);
            color = normalize(color);
            //float3 ncolor= color;
            color = dot(lightvector,color);
            //float3 dotcolor = color;
            color = mix(float3(.12,0.07,0.01),float3(.5,0.8,1.0),color);
            color = abs(mix(orgcolor,color,0.3)*2.0-1.0);
            color = smoothstep(0.0,0.43,sin(color)); //gives better color contrast
            
            color = dot(lightvector,color);
            color = pow(abs(float3(.2,0.07,0.01)/color),0.7);
            //color = 1.0-color;
            
            //color = abs(orgcolor/pow(color,0.5));
            
            
          
        }
      
        
        
        
        
        float4 ret = float4(color, 1.);
        return ret;
    }
    
    
  

}}
  

