//
//  helpers.metal
//  arsimplesea
//
//  Created by TechnoRiver on 04/05/2023.
//

#include <metal_stdlib>
using namespace metal;


#ifndef Helpers_h
#define Helpers_h

#include <RealityKit/RealityKit.h>
#include <metal_stdlib>
#include <metal_types>


// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd

// By Morgan McGuire @morgan3d, http://graphicscodex.com
// Reuse permitted under the BSD license.

// All noise functions are designed for values on integer scale.
// They are tuned to avoid visible periodicity for both positive and
// negative coordinates within a few orders of magnitude.

// For a single octave
//#define NOISE noise


#define NUM_NOISE_OCTAVES 7

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

float fbm2d(float2 p) {
    
    return fbm2(float2(fbm2(p),fbm2(p-float2(3.0,2.0))));
}

float2x2 rotateAngle(float theta)
{
    float c = cos(theta);
    float s = sin(theta);
    return float2x2(c,-s,s,c);
    
}


//ver 5.3
//voronoi
float3 voronoi( float2 x , float iTime)
{
    float2 n = floor(x);
    float2 f = fract(x);

    //----------------------------------
    // first pass: regular voronoi
    //----------------------------------
    float2 mg, mr;

    float md = 8.0;
    for( int j=-1; j<=1; j++ )
    for( int i=-1; i<=1; i++ )
    {
        float2 g = float2(float(i),float(j));
        float2 o = hash2( n + g );
        #ifdef ANIMATE
        o = 0.5 + 0.5*sin( iTime + 6.2831*o );
        #endif
        float2 r = g + o - f;
        float d = dot(r,r);

        if( d<md )
        {
            md = d;
            mr = r;
            mg = g;
        }
    }

    //----------------------------------
    // second pass: distance to borders
    //----------------------------------
    md = 8.0;
    for( int j=-2; j<=2; j++ )
    for( int i=-2; i<=2; i++ )
    {
        float2 g = mg + float2(float(i),float(j));
        float2 o = hash2( n + g );
        #ifdef ANIMATE
        o = 0.5 + 0.5*sin( iTime + 6.2831*o );
        #endif
        float2 r = g + o - f;

        if( dot(mr-r,mr-r)>0.00001 )
        md = min( md, dot( 0.5*(mr+r), normalize(r-mr) ) );
    }

    return float3( md, mr );
}

//ver 5.3
#define ANIMATE

float fbm2vor(float2 x,float iTime, float basicType) {
float v = 0.0;
float a = 0.5;
float2 shift = float2(100);
// Rotate to reduce axial bias
float2x2 rot = float2x2(cos(0.5), sin(0.5), -sin(0.5), cos(0.50));
for (int i = 0; i < NUM_NOISE_OCTAVES; ++i) {
    
    //ver 5.4
    if (basicType==0)
        v += a * (sqrt(dot(voronoi(x,iTime),voronoi(x,iTime))) * noise2(x) + 0.1); //voronoi
    else if (basicType==1)
        v += a * (1.0-(abs(noise2(x)-0.5)*1.9+0.01)); //cloud like  //abs-inverted
    else if (basicType==2)
        v += a * abs(noise2(x)-0.5)*1.9+0.01; //abs
    else if (basicType==3)
        v += a * (0.7*voronoi(x,iTime).x + 0.5*voronoi(x,iTime).y + 0.1) ; //ambient-voronoi
    else if (basicType==4)
        v += a * max(noise2(x),0.12); //clamp
    else if (basicType==5)
        v += a * (voronoi(x,0.0).x+0.1); //simple voronoi
    else if (basicType==6)
        v += a * noise2(x); //original
     
        
    //v += a * noise2(x);
    
    //ver 5.4 variants
    //v += a * abs(noise2(x)-0.5)*2.0;
    ///v += a * abs(noise2(x)-0.5)*1.9+0.01;
    //v += a * max(noise2(x),0.12); //clamp
    //v += a * (1.0-(abs(noise2(x)-0.5)*1.9+0.01)); //cloud like
    
    //ver 5.3 variants
    //v += a * (sqrt(dot(voronoi(x,iTime),voronoi(x,iTime))) * noise2(x) + 0.1);
    //v += a * (voronoi(x,0.0).x+0.1);
   
    ///v += a * sqrt(dot(voronoi(x,iTime),voronoi(x,iTime)));
    //v += a * (0.7*voronoi(x,iTime).x + 0.5*voronoi(x,iTime).y + 0.1);
    
    x = rot * x * 2.0 + shift;
    a *= 0.5;
}
return v;
}


float fbm2dvor(float2 p,float iTime,float basicType) {
    
    //return fbm2(float2(fbm2(p),fbm2(p-float2(3.0,2.0))));
    return fbm2vor(float2(fbm2vor(p,iTime, basicType),fbm2vor(p-float2(3.0,2.0),iTime,basicType)),iTime,basicType);
}

//main fBM flow
//ver 5.0
//from AnimTex
float4 fBMFlow(float2 pos, float2 sizeImage, float3 org, float iTime,float density,float basicType,float colorType) {

    
    float warpType = 0.0;
    //float inputAuraMask = 0.0;
    float angle = 0.0;
    float3 inputColor = float3(0.82,0.63,0.76);
    float scale = 5.0;
    float2 translation = float2(0,0);
    float2 animVelocity = float2( 0.12, 0.09);
    float2 animScale = float2(0.4632,0.7567);
    
    float paletteInterpolate = 0.0;
    float3 inputColor2 = float3(0.111961,0.519608,0.24678);

    //float density = 120;
    //float basicType = 3.0;
    //float colorType = 2.0; //0 1 2
    
    //currently text / mask image have to be same size as fbm inputimage
    //float2 pos = sampledImage.coord();
    //float2 sizeImage = inputImage.size();
    //float3 org = inputImage.sample(pos).rgb;
    
    //Normalize coordinates
    float2 uv = float2(pos.x,pos.y);
    float2 p = uv-0.5;
    p.x *= sizeImage.x / sizeImage.y;
  
    float3 color = inputColor;
    float3 color2 = inputColor2;
    float2x2 rotatematrix = rotateAngle(angle*3.14149/180.0);
    
    
    //Actual coordinates
    //p = rotatematrix*p*scale+translation;
    p = (rotatematrix*p+0.5)*scale+translation;
   
    
    //float2x2 timerotation = rotateAngle(iTime);
    //float2 offsetpos=timerotation*(p + fbm2d(p) * animScale);
    
    //Domain Warp Coordinates
    float2 offsetpos=p + fbm2d(p) * animScale;
    offsetpos=rotateAngle(60*3.14149/180.0)*offsetpos;
    //offsetpos=offsetpos-normalize(offsetpos);
    //float2 disp = fbm2d(offsetpos) + rotateAngle(iTime*0.01)*animVelocity*iTime;
    float2 disp = fbm2dvor(offsetpos,iTime,basicType) + rotateAngle(iTime*0.01)*animVelocity*iTime;
    //float2 disp = fbm2dvor(offsetpos,iTime);
    //disp = timerotation*offsetpos;
    
    //Warp Function on FBM Texture
    float3 val = fbm2vor(p + disp - normalize(disp)*0.72,iTime,basicType);  //default
    if (warpType==1)
    {
        val = fbm2vor(p+sin(disp),iTime,basicType);
        
    }
    else if (warpType==1)
    {
        val = fbm2vor(p+clamp(sin(disp)*disp,0,1),iTime,basicType);
        
    }
    else if (warpType==2)
    {
        val = fbm2vor(p+length(disp),iTime,basicType);
        
    }
    else if (warpType==3)
    {
        val = fbm2vor(p+abs(sinh(disp)),iTime,basicType);
    }
    else if (warpType==4)
    {
        val = fbm2vor(p+fbm2(sin(disp*disp)),iTime,basicType);
    }
    else if (warpType==5)
    {
        val = fbm2vor(p+disp*sin(iTime*0.5),iTime,basicType);
    }
    else if (warpType==6)
    {
        val =  fbm2vor(p+sin(disp+iTime*0.167)+clamp(cosh(sqrt(disp.y)),0.0,1.0),iTime,basicType);
    }
    else if (warpType==7)
    {
        val =  fbm2vor(p+pow(disp,1.37),iTime,basicType);
    }
    else if (warpType==8)
    {
        val =   fbm2vor(p+cos(disp)*sin(pow(disp,1.76)),iTime,basicType);
    }
    else if (warpType==9)
    {
        val = fbm2vor(p/((disp+1.0)),iTime,basicType);
    }
    else if (warpType==10)
    {
        //
        val = fbm2vor(p/(fbm2(disp)+1.0),iTime,basicType);
    }
    else if (warpType==11)
    {
        val =  fbm2vor(p/(fbm2(disp)+1.0)+disp*0.2,iTime,basicType);
    }
 
    
    
    //demo of blending 2 functions
    //float val2 =  fbm2vor(p/(fbm2vor(disp,iTime)+1.21),iTime);
   
    //float val2 =  fbm2(p/(fbm2vor(disp,iTime)+1.21));
    
    
    float2 offsetpos2=rotateAngle(180*3.14149/180.0)*offsetpos;
    float2 disp2 = fbm2dvor(offsetpos2,iTime,basicType)*rotateAngle(180*3.14149/180.0)*animVelocity*iTime;
    float val2 =  fbm2vor(p/(fbm2vor(disp2,iTime,basicType)+1.21),iTime,basicType);
    
      
    
   
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
   
    
    
    float dd = density/100.0;
    float3 density_adjval = clamp(pow(val,dd)*2.26,0.0,1.0); //a simple exp function...generci can use tone curve
    
    if (colorType==0)
    {
        //cloud
        color = mix(float3(1,1,1),
                    color,  //background
                    density_adjval); //density
    }
    else  if (colorType==1)
    {
        //fire
        density_adjval = 1.0/density_adjval;
        color = float3(.15,0.06,0.008)*density_adjval; //set density to 200++ //fixed color
       
    }
    else  if (colorType==2)
    {
        color = density_adjval*sinh(density_adjval)*color;
        
       
    }
    else  if (colorType==3)
    {
        float3 basecolor = float3(0.1,0.42,0.8);
        
        density_adjval = 1.0/(density_adjval+0.2);
        color = basecolor*density_adjval; //set density to 200++ //fixed color
       
        //color = density_adjval*sinh(density_adjval)*basecolor;
        
       
    }

    
    float h = fbm2vor(p,iTime, basicType);
    
    float4 ret = float4(color,h); //simple value of height in alpha
    
    //float4 ret = float4(pow(val,2.2)*color,1.0);
   
    return ret;
  
    
        
   
}


//ver 5.1
float fBMheightmapx(float2 p,float iTime, float warpType,float2 animVelocity,float angle) {
    float h = 0.;
    
    /*
    //too slow
    float2 uv= p;
    float4 valx = fBMFlow(uv, float2(1024,1024), float3(0,0,0), iTime);
    h= valx.x;
    h = .8 * h + .2; ///ambient height
    
    //h=pow(h,2.262)*sinh(h); //gives better contrast
     
    return h;
   */
    
    
    //can use tesxture directly
    
    float2x2 rotatematrix = rotateAngle(angle*3.14149/180.0);
    animVelocity =  rotatematrix*animVelocity;
  
    
    float2 offsetpos=p + fbm2d(p);
    offsetpos=rotateAngle(60*3.14149/180.0)*offsetpos;
    float2 disp = fbm2d(offsetpos) + rotateAngle(iTime*0.01)*animVelocity*iTime;
  
    //Warp Function on FBM Texture
    float3 val = fbm2(p + disp);  //default
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
 
    
    h= val.x;
    //h=1.0-abs(h);
    
    
    h = .8 * h + .2; ///ambient height
    
    //h=pow(h,2.262)*sinh(h); //gives better contrast
     
    return h;
    
}


float3 computeNormal(float2 p,float t,float warpType,float2 animVelocity,float angle,float screensize) {
    
    
    float e = 1.0/screensize;
    return normalize(float3(
        fBMheightmapx(p - float2(e,0.0) ,t,warpType,animVelocity,angle) - fBMheightmapx(p + float2(e,0.0),t,warpType,animVelocity,angle),
                            fBMheightmapx(p - float2(0,e),t,warpType,animVelocity,angle) - fBMheightmapx(p + float2(0,e),t,warpType,animVelocity,angle),
        -2. * e));
    
}

float3 getBackgroundFromHeight(float x) {
    
    return float3(pow(x,2.5),pow(x,1.7),x); //non linear gives better shading
    //return float3(x,x,x);
}

#endif /* Helpers_h */
