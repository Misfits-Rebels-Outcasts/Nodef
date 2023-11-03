//
//  Copyright © 2022 James Boo. All rights reserved.
//
#include <metal_stdlib>
using namespace metal;

#include <CoreImage/CoreImage.h> // includes CIKernelMetalLib.h

float2x2 rotation(float theta)
{   float c = cos(theta);
        float s = sin(theta);
        return float2x2(c,-s,s,c);
    
}

extern "C" { namespace coreimage {

   
    float3 makeGradient(float len, float angle, float rangeType, float3 color1,float3 color2,float aspect)
    {
        
        float3 valmix = float3(len,len,len);
        //valmix = sin(valmix*3.14159/2.0*aspect)*0.5+0.5;
        
        rangeType=int(rangeType);
       
        //using
        if (rangeType==0)
        {
            valmix = sin(valmix*3.14159/2.0*aspect); //type 0-90
        }
        else if (rangeType==1)
        {
            valmix = sin(valmix*3.14159*aspect-(3.14159/2.0))*0.5+0.5;
        }
        else
        {
            valmix = sin((valmix*3.14159/2.0-3.14159*0.75)*aspect)+1.0; //type 270 to 360
        }
       
        /*
        float len2 = 1.0-length(uvmod);
         float len2 = length(uvmod);
        float3 valmix2 = float3(len2,len2,len2);
        valmix2 = sin(valmix2*3.14159*aspect-(3.14159/2.0))*0.5+0.5;
        float3 cxx2 = mix(color1,color2,valmix2);
       */
   
        //consideration
        //valmix = sin((valmix*3.1415-(3.14159/2.0))*aspect)*0.5+0.5; //type 90 to 270
       
        //valmix = sin(valmix*3.14159*0.5/aspect)*0.5+0.5;;
       // valmix = sin(valmix*3.14159/aspect)*0.5+0.5;;
        
        
        //val= uvmod.x;
        
        
        //float3 cxx = float3(pos.x,0.0,0.0); //linear shading
        //float3 cxx = float3(pos.x,pos.x*0.12,pos.y); //linear shading
        //cxx = sinh(cxx*3.14159*0.09)*1.2-0.02; //sine shading //freq mult 0.05 to 0.3  //sin, sinh, asin
        
        
        //float3 cxx = color1 * (1.0-valmix) + color2 * (valmix);
        float3 cxx = mix(color1,color2,valmix);
        return cxx;
        
        
    }
    
   
    //ver 1.0
    float4 gradientnl(sampler sourceImage, float2 center, float angle, float rangeType, float3 color1,float3 color2,float2 center_2, float angle_2, float rangeType_2, float3 color1_2,float3 color2_2, float useSecondGrad, float blendweight) {

        
        float2 pos = sourceImage.coord();
        float2 sizeImage = sourceImage.size();
        //float3 org = sourceImage.sample(pos).rgb;
    
        
        //////
     
        float2 uv = float2(pos.x,pos.y);
        float2 p = 2. * uv - 1;
        p.x *= sizeImage.x / sizeImage.y;
           
        
        //Gradient Generator
      
        //sinusoidal shading for gradients background
        float aspect = sizeImage.y / sizeImage.x ;
        float radians = angle*3.14159/180;
        float radians_2 = angle_2*3.14159/180;
        float2x2 mt = rotation(radians);
        float2x2 mt_2 = rotation(radians_2);
        //float len = length(uv);
        //float2 uvmod = len*float2(cos(radians),sin(radians));
        //float3 valmix = float3(val,val,val);
        //val = sin(uvmod.x);
        float2 uvmod = mt*uv+center;
        float2 uvmod_2 = mt_2*uv+center_2;
        float len = uvmod.x;
        float len_2 = uvmod_2.x;
        //len = 1.0-len;
        
        float3 cxx = makeGradient(len, angle, rangeType,  color1,color2,aspect);
        
        float3 cxx2 = makeGradient(len_2, angle_2, rangeType_2,  color1_2,color2_2,aspect);
        
        if (useSecondGrad)
        {
            cxx = mix(cxx,cxx2,blendweight);
            //cxx=cxx2;
        }
        
        
        
        return float4(cxx,1.0);
        
     
    }
    
  /*
   
    //ver 1.0
    float4 gradientnl(sampler sourceImage, float2 center, float angle, float rangeType, float3 color1,float3 color2) {

        
        float2 pos = sourceImage.coord();
        float2 sizeImage = sourceImage.size();
        float3 org = sourceImage.sample(pos).rgb;
    
        
        //////
     
        float2 uv = float2(pos.x,pos.y);
        float2 p = 2. * uv - 1;
        p.x *= sizeImage.x / sizeImage.y;
           
        
        //Gradient Generator
      
        //sinusoidal shading for gradients background
        float aspect = sizeImage.y / sizeImage.x ;
        float radians = angle*3.14159/180;
        float2x2 mt = rotation(radians);
        //float len = length(uv);
        //float2 uvmod = len*float2(cos(radians),sin(radians));
        //float3 valmix = float3(val,val,val);
        //val = sin(uvmod.x);
        float2 uvmod = mt*uv;
        float len = uvmod.x;
        //len = 1.0-len;
        
        
        float3 valmix = float3(len,len,len);
        //valmix = sin(valmix*3.14159/2.0*aspect)*0.5+0.5;
       
        //using
        //valmix = sin(valmix*3.14159/2.0*aspect); //type 0-90
        //valmix = sin(valmix*3.14159*aspect-(3.14159/2.0))*0.5+0.5; //type 90 to 270
        valmix = sin((valmix*3.14159/2.0-3.14159*0.75)*aspect)+1.0; //type 270 to 360
       
        
        //float len2 = 1.0-length(uvmod);
         //float len2 = length(uvmod);
        //float3 valmix2 = float3(len2,len2,len2);
        //valmix2 = sin(valmix2*3.14159*aspect-(3.14159/2.0))*0.5+0.5;
        //float3 cxx2 = mix(color1,color2,valmix2);
       
   
        //org
        //float3 cxx = float3(pos.x,0.0,0.0); //linear shading
        //float3 cxx = float3(pos.x,pos.x*0.12,pos.y); //linear shading
        //cxx = sinh(cxx*3.14159*0.09)*1.2-0.02; //sine shading //freq mult 0.05 to 0.3  //sin, sinh, asin
        
        
        //float3 cxx = color1 * (1.0-valmix) + color2 * (valmix);
        float3 cxx = mix(color1,color2,valmix);
        
        //cxx = mix(cxx,cxx2,0.5);
        
        
        return float4(cxx,1.0);
        
     
    }
   
   */

}}
  
