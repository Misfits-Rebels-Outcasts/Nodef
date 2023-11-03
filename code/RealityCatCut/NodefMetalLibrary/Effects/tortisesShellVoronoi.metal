//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//  Original code is under the Original License below
//  The ported derivative is available under GPL2.0

//Voronoi
//https://www.shadertoy.com/view/ldl3W8

// The MIT License
// Copyright © 2013 Inigo Quilez
// https://www.youtube.com/c/InigoQuilez
// https://iquilezles.org/
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

// I've not seen anybody out there computing correct cell interior distances for Voronoi
// patterns yet. That's why they cannot shade the cell interior correctly, and why you've
// never seen cell boundaries rendered correctly.
//
// However, here's how you do mathematically correct distances (note the equidistant and non
// degenerated grey isolines inside the cells) and hence edges (in yellow):
//
// https://iquilezles.org/articles/voronoilines
//
// More Voronoi shaders:
//
// Exact edges:  https://www.shadertoy.com/view/ldl3W8
// Hierarchical: https://www.shadertoy.com/view/Xll3zX
// Smooth:       https://www.shadertoy.com/view/ldB3zc
// Voronoise:    https://www.shadertoy.com/view/Xd23Dh


#include <metal_stdlib>
using namespace metal;


#include <CoreImage/CoreImage.h> // includes CIKernelMetalLib.h


extern "C" { namespace coreimage {
    
    //hash2 using morgon3d version
    // Precision-adjusted variations of https://www.shadertoy.com/view/4djSRW
    float tsv_hash(float p) { p = fract(p * 0.011); p *= p + 7.5; p *= p + p; return fract(p); }
    float tsv_hash2(float2 p) {float3 p3 = fract(float3(p.xyx) * 0.13); p3 += dot(p3, p3.yzx + 3.333); return fract((p3.x + p3.y) * p3.z); }

    
    float2x2 tsv_rotateAngle(float theta)
    {
        float c = cos(theta);
        float s = sin(theta);
        return float2x2(c,-s,s,c);
        
    }
    #define ANIMATE
 
    
    float3 tsv_voronoi( float2 x , float iTime)
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
            float2 o = tsv_hash2( n + g );
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
            float2 o = tsv_hash2( n + g );
            #ifdef ANIMATE
            o = 0.5 + 0.5*sin( iTime + 6.2831*o );
            #endif
            float2 r = g + o - f;

            if( dot(mr-r,mr-r)>0.00001 )
            md = min( md, dot( 0.5*(mr+r), normalize(r-mr) ) );
        }

        return float3( md, mr );
    }

    
    
    //ver 1.1
    float4 tortiseShellVoronoi(sampler inputImage, sampler sampledImage, float warpType, float inputAuraMask, float angle, float iTime,float3 inputColor, float scale, float2 translation,float2 animVelocity,float2 animScale,float paletteInterpolate, float3 inputColor2) {

        
        //currently text / mask image have to be same size as fbm inputimage
        float2 pos = sampledImage.coord();
        float2 sizeImage = inputImage.size();
        //float3 org = inputImage.sample(pos).rgb;
        
        //Normalize coordinates
        float2 uv = float2(pos.x,pos.y);
        float2 p = uv-0.5;
        //p.x *= sizeImage.x / sizeImage.y;
      
        //float3 color = inputColor;
        //float3 color2 = inputColor2;
        //float2x2 rotatematrix = tsv_rotateAngle(angle*3.14149/180.0);
        
        
        //
        //vec2 p = fragCoord/iResolution.xx;
        p = uv;  p.x *= sizeImage.x / sizeImage.y;

      
        
        float3 c = tsv_voronoi( 8.0*p, iTime );
        //float3 col = c;
        
        
        // isolines
        //float3 col = c.x*(0.5 + 0.5*sin(64.0*c.x))*float3(1.0);
        float3 col = c.x*0.5;
        
        
        // borders
        col = mix( float3(1.0,0.6,0.0), col, smoothstep( 0.04, 0.07, c.x ) );
        // feature points
        float dd = length( c.yz );
        col = mix( float3(1.0,0.6,0.1), col, smoothstep( 0.0, 0.12, dd) );
        col += float3(1.0,0.6,0.1)*(1.0-smoothstep( 0.0, 0.04, dd));
         
        
        float4 fragColor = float4(col,1.0);
        return fragColor ;
        
           
       
    }
    
    
  

}}
  


