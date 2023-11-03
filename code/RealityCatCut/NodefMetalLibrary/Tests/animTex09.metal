//
//  animTex01.metal
//  SketchEffects
//
//  Created by TechnoRiver on 27/09/2022.
//


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
    
    #define NUM_NOISE_OCTAVESX1 7
    /*

    
    // Precision-adjusted variations of https://www.shadertoy.com/view/4djSRW
    float hash(float p) { p = fract(p * 0.011); p *= p + 7.5; p *= p + p; return fract(p); }
    float hash2(float2 p) {float3 p3 = fract(float3(p.xyx) * 0.13); p3 += dot(p3, p3.yzx + 3.333); return fract((p3.x + p3.y) * p3.z); }

    
    float noise(float x) {
        float i = floor(x);
        float f = fract(x);
        float u = f * f * (3.0 - 2.0 * f);
        return mix(hash(i), hash(i + 1.0), u);
    }


    float noise2(float2 x) {
        float2 i = floor(x);
        float2 f = fract(x);

        // Four corners in 2D of a tile
        float a = hash2(i);
        float b = hash2(i + float2(1.0, 0.0));
        float c = hash2(i + float2(0.0, 1.0));
        float d = hash2(i + float2(1.0, 1.0));

        // Simple 2D lerp using smoothstep envelope between the values.
        // return float3(mix(mix(a, b, smoothstep(0.0, 1.0, f.x)),
        //            mix(c, d, smoothstep(0.0, 1.0, f.x)),
        //            smoothstep(0.0, 1.0, f.y)));

        // Same code, with the clamps in smoothstep and common subexpressions
        // optimized away.
        float2 u = f * f * (3.0 - 2.0 * f);
        return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
    }


    float noise3(float3 x) {
        const float3 step = float3(110, 241, 171);

        float3 i = floor(x);
        float3 f = fract(x);
     
        // For performance, compute the base input to a 1D hash from the integer part of the argument and the
        // incremental change to the 1D based on the 3D -> 1D wrapping
        float n = dot(i, step);

        float3 u = f * f * (3.0 - 2.0 * f);
        return mix(mix(mix( hash(n + dot(step, float3(0, 0, 0))), hash(n + dot(step, float3(1, 0, 0))), u.x),
                       mix( hash(n + dot(step, float3(0, 1, 0))), hash(n + dot(step, float3(1, 1, 0))), u.x), u.y),
                   mix(mix( hash(n + dot(step, float3(0, 0, 1))), hash(n + dot(step, float3(1, 0, 1))), u.x),
                       mix( hash(n + dot(step, float3(0, 1, 1))), hash(n + dot(step, float3(1, 1, 1))), u.x), u.y), u.z);
    }


    float fbm(float x) {
        float v = 0.0;
        float a = 0.5;
        float shift = float(100);
        for (int i = 0; i < NUM_NOISE_OCTAVES; ++i) {
            v += a * noise(x);
            x = x * 2.0 + shift;
            a *= 0.5;
        }
        return v;
    }


    float fbm2(float2 x) {
        float v = 0.0;
        float a = 0.5;
        float2 shift = float2(100);
        // Rotate to reduce axial bias
        float2x2 rot = float2x2(cos(0.5), sin(0.5), -sin(0.5), cos(0.50));
        for (int i = 0; i < NUM_NOISE_OCTAVES; ++i) {
            v += a * noise2(x);
            x = rot * x * 2.0 + shift;
            a *= 0.5;
        }
        return v;
    }


    float fbm3(float3 x) {
        float v = 0.0;
        float a = 0.5;
        float3 shift = float3(100);
        for (int i = 0; i < NUM_NOISE_OCTAVES; ++i) {
            v += a * noise3(x);
            x = x * 2.0 + shift;
            a *= 0.5;
        }
        return v;
    }

    
    //extension functions



   */
    
    float hash2x1(float2 p) {float3 p3 = fract(float3(p.xyx) * 0.13); p3 += dot(p3, p3.yzx + 3.333); return fract((p3.x + p3.y) * p3.z); }

    float noise2x1(float2 x) {
        float2 i = floor(x);
        float2 f = fract(x);

        // Four corners in 2D of a tile
        float a = hash2x1(i);
        float b = hash2x1(i + float2(1.0, 0.0));
        float c = hash2x1(i + float2(0.0, 1.0));
        float d = hash2x1(i + float2(1.0, 1.0));

        // Simple 2D lerp using smoothstep envelope between the values.
        // return float3(mix(mix(a, b, smoothstep(0.0, 1.0, f.x)),
        //            mix(c, d, smoothstep(0.0, 1.0, f.x)),
        //            smoothstep(0.0, 1.0, f.y)));

        // Same code, with the clamps in smoothstep and common subexpressions
        // optimized away.
        float2 u = f * f * (3.0 - 2.0 * f);
        return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
    }

    float fbm2x1(float2 x) {
        float v = 0.0;
        float a = 0.5;
        float2 shift = float2(100);
        // Rotate to reduce axial bias
        float2x2 rot = float2x2(cos(0.5), sin(0.5), -sin(0.5), cos(0.50));
        for (int i = 0; i < NUM_NOISE_OCTAVESX1; ++i) {
            v += a * noise2x1(x);
            x = rot * x * 2.0 + shift;
            a *= 0.5;
        }
        return v;
    }

    
    float fbm2dx1(float2 p) {
        
        return fbm2x1(float2(fbm2x1(p),fbm2x1(p-float2(3.0,2.0))));
    }
    
    
    float2x2 rotateAnglex1(float theta)
    {
        float c = cos(theta);
        float s = sin(theta);
        return float2x2(c,-s,s,c);
        
    }
    
    float heightmapx1(float2 p,float iTime, float warpType,float2 animVelocity,float angle) {
        float h = 0.;
        
        
        //can use tesxture directly
        
        float2x2 rotatematrix = rotateAnglex1(angle*3.14149/180.0);
        animVelocity =  rotatematrix*animVelocity;
      
        
        float2 offsetpos=p + fbm2dx1(p);
        offsetpos=rotateAnglex1(60*3.14149/180.0)*offsetpos;
        float2 disp = fbm2dx1(offsetpos) + rotateAnglex1(iTime*0.01)*animVelocity*iTime;
      
        //Warp Function on FBM Texture
        float3 val = fbm2x1(p + disp);  //default
        /*
        if (warpType==1)
        {
            val = fbm2(p+sin(disp));
            
        }
        else if (warpType==1)
        {
            val = fbm2(p+clamp(sin(disp)*disp,0,1));
            
        }
        else if (warpType==2)
        {
            val = fbm2(p+length(disp));
            
        }
        else if (warpType==3)
        {
            val = fbm2(p+abs(sinh(disp)));
        }
        else if (warpType==4)
        {
            val = fbm2(p+fbm2(sin(disp*disp)));
        }
        else if (warpType==5)
        {
            val = fbm2(p+disp*sin(iTime*0.5));
        }
        else if (warpType==6)
        {
            val =  fbm2(p+sin(disp+iTime*0.167)+clamp(cosh(sqrt(disp.y)),0.0,1.0));
        }
        else if (warpType==7)
        {
            val =  fbm2(p+pow(disp,1.37));
        }
        else if (warpType==8)
        {
            val =   fbm2(p+cos(disp)*sin(pow(disp,2.32)));
        }
        else if (warpType==9)
        {
            val = fbm2(p/((disp+1.0)));
        }
        else if (warpType==10)
        {
            //
            val = fbm2(p/(fbm2(disp)+1.0));
        }
        else if (warpType==11)
        {
            val =  fbm2(p/(fbm2(disp)+1.0)+disp*0.2);
        }
     */
        
        h= val.x;
        
        /*
        float val2 =  fbm2(p/(fbm2(disp)+1.21));
        //if (paletteInterpolate==1.0)
        //{
            
            float h2 = mix(val2,h,
                        clamp(pow(val2,3.12)*3.26,0.0,1.0));
            
        //}
       */
       
        
        //float c=2.7;
        //float2 offset =   noise(5. * p + iTime * float2(0.3, .05) + float2(13., 37.));
        //h = noise(c*p+offset); //standard displacement, vary c for flater or more bumpy effects
        //h = .65 * h + .33; ///ambient height term
        //h = .65 * h + .33 * h2;
        h = .8 * h + .2;
        
        //h=pow(h,2.262)*sinh(h); //gives better contrast
         
        return h;
        
    }

    float3 calcNormalx1(float2 p,float t,float warpType,float2 animVelocity,float angle) {
        float2 e = float2(1e-3, 0);
        return normalize(float3(
            heightmapx1(p - e.xy,t,warpType,animVelocity,angle) - heightmapx1(p + e.xy,t,warpType,animVelocity,angle),
            heightmapx1(p - e.yx,t,warpType,animVelocity,angle) - heightmapx1(p + e.yx,t,warpType,animVelocity,angle),
            -2. * e.x));
    }

    float3 getColorx1(float x) {
        
        /*
        //bilerp of color
        float3 a = float3(.1, .0, .03);
        float3 b = float3(1., .03, .07);
        float3 c = float3(.4, .2, .3);
        return mix(a, mix(b, c, smoothstep(.4, .9, x)), smoothstep(.0, .9, x));
         */
        //return float3(pow(x,4.5),pow(x,3.7),x); //non linear gives better
        
        //return float3(pow(x,3.5),pow(x,2.7),x); //non linear gives better
        return float3(pow(x,2.5),pow(x,1.7),x); //non linear gives better shading
        //return float3(x,x,x);
    }

  
    
    //ver 1.1
    float4 animTex09Filter(sampler inputImage, sampler sampledImage, float warpType, float inputAuraMask, float angle, float iTime,float3 inputColor, float scale, float2 translation,float2 animVelocity,float2 animScale,float paletteInterpolate, float3 inputColor2) {

        
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
        float2x2 rotatematrix = rotateAnglex1(angle*3.14149/180.0);
        
        
        //Actual coordinates
        //p = rotatematrix*p*scale+translation;
        p = (rotatematrix*p+0.5)*scale+translation;
       
        
        //Domain Warp Coordinates
        
        float h = heightmapx1( p, iTime, warpType,animVelocity,angle);
       
        
        //Rendering
        float3 v = float3(h);
        v.yz *= 3.;
        float3 nor = calcNormalx1(uv,iTime,warpType,animVelocity,angle);
        nor.xy *= .4;
        nor = normalize(nor);

        float3 mat = getColorx1(h);
        mat = clamp(mat, 0., 1.);
        float3 ld = normalize(float3(1,-1.,1));
        float3 ha = normalize(ld - float3(0.,0,-1));
    
        
        float3 col = float3(0);
        col += mat * .8;
        col += .2 * mat * pow(max(dot(normalize(nor + float3(.0,0,0)), -ld), 0.), 3.);
        
        
        //float3 ld2 = normalize(float3(3,-5.,2.0));
        //col += .2 * mat * pow(max(dot(normalize(nor + float3(.0,0,0)), -ld2), 0.), 2.);
        
        
        
      
        //enough for shading
        col += .3 * h * pow(dot(normalize(nor + float3(.0,0,0)), ha), 20.);
        
        
        //try ha2
        //additional lights
        float3 ha2 = normalize(ld - float3(2.,6,-15));
        col += .3 * h * pow(dot(normalize(nor + float3(.0,0,0)), ha2), 20.);
         
        
        float3 ha3 = normalize(ld - float3(8.,2,-17));
        col += .3 * h * pow(dot(normalize(nor + float3(.0,0,0)), ha3), 20.);

        //if(h > 1.) col = vec3(0,1,0);
        //if(h < 0.) col = vec3(0,0,1);
        
        //col = mix(col, getColor(fragCoord.x/iResolution.x), step(abs(uv.y), .1));
        color = col;
       
        
       
        //demo of blending 2 functions
        /*
        float2 offsetpos=p + fbm2d(p);
        float2 disp = fbm2d(offsetpos) + rotateAngle(iTime*0.01)*animVelocity*iTime;
        
       
        float val2 =  fbm2(p/(fbm2(disp)+1.21));
        if (paletteInterpolate==1.0)
        {
            
            color = mix(color2,color,
                        clamp(pow(val2,3.12)*3.26,0.0,1.0));
            
        }
        else if (paletteInterpolate==2.0)
        {
           
            //choose a gradient as image
           // color = mix(float3(fbm(org.x),fbm(org.y),fbm(org.z)),
            color = mix(org,
                       color,
                        clamp(pow(val2,3.12)*3.26,0.0,1.0));
          
           
      
        }
        */
        
        float4 ret = float4(color, 1.);
     
       
        //float4 ret = float4(pow(f,2.2)*sin(f)*color,1.0);
        //float4 ret = float4(pow(h,2.262)*sinh(h)*color,1.0);
        
    
        return ret;
         
           
       
    }
    
    
  

}}
  


