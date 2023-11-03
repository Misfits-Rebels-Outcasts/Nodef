//
//  Copyright © 2022 James Boo. All rights reserved.
//  Original code is under the Original License
//  The ported derivative is available under GPL2.0

//Based on : The Book of Shaders: Fractal Brownian Motion
//https://thebookofshaders.com/13/
//https://www.shadertoy.com/view/llySRV


#include <metal_stdlib>
using namespace metal;


#include <CoreImage/CoreImage.h> // includes CIKernelMetalLib.h

extern "C" { namespace coreimage {
    
    
    // Based on Morgan McGuire @morgan3d
    // https://www.shadertoy.com/view/4dS3Wd
    
    // By Morgan McGuire @morgan3d, http://graphicscodex.com
    // Reuse permitted under the BSD license.

    // All noise functions are designed for values on integer scale.
    // They are tuned to avoid visible periodicity for both positive and
    // negative coordinates within a few orders of magnitude.

    // For a single octave
    //#define NOISE noise
    
    
    #define WEF_NUM_NOISE_OCTAVES 7
    
    // Precision-adjusted variations of https://www.shadertoy.com/view/4djSRW
    float wef_hash(float p) { p = fract(p * 0.011); p *= p + 7.5; p *= p + p; return fract(p); }
    float wef_hash2(float2 p) {float3 p3 = fract(float3(p.xyx) * 0.13); p3 += dot(p3, p3.yzx + 3.333); return fract((p3.x + p3.y) * p3.z); }

    
    float wef_noise(float x) {
        float i = floor(x);
        float f = fract(x);
        float u = f * f * (3.0 - 2.0 * f);
        return mix(wef_hash(i), wef_hash(i + 1.0), u);
    }


    float wef_noise2(float2 x) {
        float2 i = floor(x);
        float2 f = fract(x);

        // Four corners in 2D of a tile
        float a = wef_hash2(i);
        float b = wef_hash2(i + float2(1.0, 0.0));
        float c = wef_hash2(i + float2(0.0, 1.0));
        float d = wef_hash2(i + float2(1.0, 1.0));

        // Simple 2D lerp using smoothstep envelope between the values.
        // return float3(mix(mix(a, b, smoothstep(0.0, 1.0, f.x)),
        //            mix(c, d, smoothstep(0.0, 1.0, f.x)),
        //            smoothstep(0.0, 1.0, f.y)));

        // Same code, with the clamps in smoothstep and common subexpressions
        // optimized away.
        float2 u = f * f * (3.0 - 2.0 * f);
        return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
    }


    float wef_noise3(float3 x) {
        const float3 step = float3(110, 241, 171);

        float3 i = floor(x);
        float3 f = fract(x);
     
        // For performance, compute the base input to a 1D hash from the integer part of the argument and the
        // incremental change to the 1D based on the 3D -> 1D wrapping
        float n = dot(i, step);

        float3 u = f * f * (3.0 - 2.0 * f);
        return mix(mix(mix( wef_hash(n + dot(step, float3(0, 0, 0))), wef_hash(n + dot(step, float3(1, 0, 0))), u.x),
                       mix( wef_hash(n + dot(step, float3(0, 1, 0))), wef_hash(n + dot(step, float3(1, 1, 0))), u.x), u.y),
                   mix(mix( wef_hash(n + dot(step, float3(0, 0, 1))), wef_hash(n + dot(step, float3(1, 0, 1))), u.x),
                       mix( wef_hash(n + dot(step, float3(0, 1, 1))), wef_hash(n + dot(step, float3(1, 1, 1))), u.x), u.y), u.z);
    }


    float wef_fbm(float x) {
        float v = 0.0;
        float a = 0.5;
        float shift = float(100);
        for (int i = 0; i < WEF_NUM_NOISE_OCTAVES; ++i) {
            v += a * wef_noise(x);
            x = x * 2.0 + shift;
            a *= 0.5;
        }
        return v;
    }


    float wef_fbm2(float2 x) {
        float v = 0.0;
        float a = 0.5;
        float2 shift = float2(100);
        // Rotate to reduce axial bias
        float2x2 rot = float2x2(cos(0.5), sin(0.5), -sin(0.5), cos(0.50));
        for (int i = 0; i < WEF_NUM_NOISE_OCTAVES; ++i) {
            v += a * wef_noise2(x);
            x = rot * x * 2.0 + shift;
            a *= 0.5;
        }
        return v;
    }


    float wef_fbm3(float3 x) {
        float v = 0.0;
        float a = 0.5;
        float3 shift = float3(100);
        for (int i = 0; i < WEF_NUM_NOISE_OCTAVES; ++i) {
            v += a * wef_noise3(x);
            x = x * 2.0 + shift;
            a *= 0.5;
        }
        return v;
    }

    
    //extension functions

    float wef_fbm2d(float2 p) {
        
        return wef_fbm2(float2(wef_fbm2(p),wef_fbm2(p-float2(3.0,2.0))));
    }
    
    float2x2 wef_rotateAngle(float theta)
    {
        float c = cos(theta);
        float s = sin(theta);
        return float2x2(c,-s,s,c);
        
    }
   

    float wef_heightmapx(float2 p,float iTime, float warpType,float2 animVelocity,float angle) {
        float h = 0.;
        
        
        //can use tesxture directly
        
        float2x2 rotatematrix = wef_rotateAngle(angle*3.14149/180.0);
        animVelocity =  rotatematrix*animVelocity;
      
        
        float2 offsetpos=p + wef_fbm2d(p);
        offsetpos=wef_rotateAngle(60*3.14149/180.0)*offsetpos;
        float2 disp = wef_fbm2d(offsetpos) + wef_rotateAngle(iTime*0.01)*animVelocity*iTime;
      
        //Warp Function on FBM Texture
        float3 val = wef_fbm2(p + disp);  //default
        if (warpType==1)
        {
            val = wef_fbm2(p+sin(disp));
            
        }
        else if (warpType==1)
        {
            val = wef_fbm2(p+clamp(sin(disp)*disp,0,1));
            
        }
        else if (warpType==2)
        {
            val = wef_fbm2(p+length(disp));
            
        }
        else if (warpType==3)
        {
            val = wef_fbm2(p+abs(sinh(disp)));
        }
        else if (warpType==4)
        {
            val = wef_fbm2(p+wef_fbm2(sin(disp*disp)));
        }
        else if (warpType==5)
        {
            val = wef_fbm2(p+disp*sin(iTime*0.5));
        }
        else if (warpType==6)
        {
            val =  wef_fbm2(p+sin(disp+iTime*0.167)+clamp(cosh(sqrt(disp.y)),0.0,1.0));
        }
        else if (warpType==7)
        {
            val =  wef_fbm2(p+pow(disp,1.37));
        }
        else if (warpType==8)
        {
            val =   wef_fbm2(p+cos(disp)*sin(pow(disp,2.32)));
        }
        else if (warpType==9)
        {
            val = wef_fbm2(p/((disp+1.0)));
        }
        else if (warpType==10)
        {
            //
            val = wef_fbm2(p/(wef_fbm2(disp)+1.0));
        }
        else if (warpType==11)
        {
            val =  wef_fbm2(p/(wef_fbm2(disp)+1.0)+disp*0.2);
        }
     
        
        h= val.x;
        
        
        h = .8 * h + .2; ///ambient height
        
        //h=pow(h,2.262)*sinh(h); //gives better contrast
         
        return h;
        
    }

    float3 wef_computeNormal(float2 p,float t,float warpType,float2 animVelocity,float angle,float screensize) {
        
        
        float e = 1.0/screensize;
        return normalize(float3(
                                wef_heightmapx(p - float2(e,0.0) ,t,warpType,animVelocity,angle) - wef_heightmapx(p + float2(e,0.0),t,warpType,animVelocity,angle),
                                wef_heightmapx(p - float2(0,e),t,warpType,animVelocity,angle) - wef_heightmapx(p + float2(0,e),t,warpType,animVelocity,angle),
            -2. * e));
        
    }

    float3 wef_getBackgroundFromHeight(float x) {
        
        return float3(pow(x,2.5),pow(x,1.7),x); //non linear gives better shading
        //return float3(x,x,x);
    }

  
    
    //ver 1.1
    float4 waterEffects(sampler inputImage, sampler sampledImage, float warpType, float inputAuraMask, float angle, float iTime,float3 inputColor, float scale, float2 translation,float2 animVelocity,float2 animScale,float paletteInterpolate, float3 inputColor2) {

        
        //currently text / mask image have to be same size as fbm inputimage
        float2 pos = sampledImage.coord();
        float2 sizeImage = inputImage.size();
        //float3 org = inputImage.sample(pos).rgb;
        
        //Normalize coordinates
        float2 uv = float2(pos.x,pos.y);
        float2 p = uv-0.5;
        p.x *= sizeImage.x / sizeImage.y;
      
        float3 color = inputColor;
        //float3 color2 = inputColor2;
        float2x2 rotatematrix = wef_rotateAngle(angle*3.14149/180.0);
        
        
        //Actual coordinates
        //p = rotatematrix*p*scale+translation;
        p = (rotatematrix*p+0.5)*scale+translation;
       
        
        //get the heightmap values
        //The heightmap is an animated fbm
        float height = wef_heightmapx( p, iTime, warpType,animVelocity,angle);
       
        
        //Rendering
        //get normals of heightmap
        float screensize = sizeImage.y;
        float3 normal = wef_computeNormal(uv,iTime,warpType,animVelocity,angle,screensize);
        normal.xy *= 0.4;
        normal = normalize(normal);
      

        //create a background with heightmap value...colorize the heightmap
        float3 background = wef_getBackgroundFromHeight(height);
        background = clamp( background, 0., 1.);
        
    
        //Simple shading with multiple directional lights
        float3 light1 = normalize(float3(-2.5,2.5,-2.5));
        float3 light2 = normalize(float3(-2.5,2.5,-3.5));
        float3 light3 = normalize(float3(-1.2,-6.7,15.2));
        float3 light4 = normalize(float3(-7.3,-3.5,18.6));
        
        float3 col = float3(0.0,0.0,0.0);
        float weight = 0.2;
        float expx = 20.0;
        
        col =  background * (1-weight);
        col += weight * background * pow(max(dot(normal, light1), 0.0), 3.0);
        
        weight = 0.3;
        col += weight * height * pow(dot(normal, light2), expx);
        col += weight  * height * pow(dot(normal, light3), expx);
        col += weight  * height * pow(dot(normal, light4), expx);

         
        color = col;
        float4 ret = float4(color, 1.);
        //float4 ret = float4(pow(h,2.262)*sinh(h)*color,1.0);
        
    
        return ret;
         
           
       
    }
    
    
  

}}
  


