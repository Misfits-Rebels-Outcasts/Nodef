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
    float powx(float x, float n)
    {
        return pow(abs(x),n);
        
    }

    //JamesChanged
    float2 hashx( float2 x )  // replace this by something better
    {
        const float2 k = float2( 0.3183099, 0.3678794 );
        x = x*k + k.yx;
        return -1.0 + 2.0*fract( 16.0 * k*fract( x.x*x.y*(x.x+x.y)) );
    }

    
    float noise(float2 p) {
        float2 i = floor( p );
        float2 f = fract( p );
        
        float2 u = f*f*(3.0-2.0*f);

        return mix( mix( dot( hashx( i + float2(0.0,0.0) ), f - float2(0.0,0.0) ),
                         dot( hashx( i + float2(1.0,0.0) ), f - float2(1.0,0.0) ), u.x),
                    mix( dot( hashx( i + float2(0.0,1.0) ), f - float2(0.0,1.0) ),
                         dot( hashx( i + float2(1.0,1.0) ), f - float2(1.0,1.0) ), u.x), u.y);
    }
    
    
    float heightmapx(float2 p,float iTime) {
        float h = 0.;
        float2 q = 4. * p + noise(-4. * p + iTime * float2(-.07, .03));
        float2 r = 7. * p + float2(37., 59.) + noise(5. * p + iTime * float2(.08, .03));
        float2 s = 3. * p + noise(5. * p + iTime * float2(.1, .05) + float2(13., 37.));
        float smoothAbs = .2;
        h += 1. * noise(s);
        h += .9 * powx(noise(q), 1. + smoothAbs);
        h += .7 * powx(noise(r), 1. + smoothAbs);
        
        h = .65 * h + .33;
        return h;
        
    }

    float3 calcNormalx(float2 p,float t) {
        float2 e = float2(1e-3, 0);
        return normalize(float3(
            heightmapx(p - e.xy,t) - heightmapx(p + e.xy,t),
            heightmapx(p - e.yx,t) - heightmapx(p + e.yx,t),
            -2. * e.x));
    }

    float3 getColor(float x) {
        float3 a = float3(.1, .0, .03);
        float3 b = float3(1., .05, .07);
        float3 c = float3(.9, .2, .3);
        return mix(a, mix(b, c, smoothstep(.4, .9, x)), smoothstep(.0, .9, x));
    }

  
   
    
    //ver 1.1
    float4 animTex01Filter(sampler inputImage, sampler sampledImage, float animType, float inputAuraMask, float angle, float iTime,float3 inputColor, float sampletype=0.0) {

        
        //currently text / mask image have to be same size as fbm inputimage
        float2 pos = sampledImage.coord();
        float2 sizeImage = inputImage.size();
        //float3 org = inputImage.sample(pos).rgb;
        
        //float3 mask = noiseSamplesReverse(pos, inputMask);
        //float3 maskExtend = noiseSamplesReverse(pos, inputMaskExtend);
    
       
     
        float2 uv = float2(pos.x,pos.y);
        
         
        float2 p = uv-0.5;
        p.x *= sizeImage.x / sizeImage.y;
        //p*= 3.;
        
      
        //float2x2 m2 = rotateMatrix(sin(iTime*1.0));
       
        
        //Actual
        float3 color = float3(0,0,0);
         
        
        uv = p;
        float h = heightmapx(uv,iTime);
        float3 v = float3(h);
        v.yz *= 3.;
        float3 nor = calcNormalx(uv,iTime);
        nor.xy *= .4;
        nor = normalize(nor);

        float3 mat = getColor(h);
        mat = clamp(mat, 0., 1.);
        float3 ld = normalize(float3(1,-1.,1));
        float3 ha = normalize(ld - float3(0.,0,-1));
            
        float3 col = float3(0);
        col += mat * .8;
        col += .2 * mat * powx(max(dot(normalize(nor + float3(.0,0,0)), -ld), 0.), 3.);
        col += .3 * h * powx(dot(normalize(nor + float3(.0,0,0)), ha), 20.);
         

        //if(h > 1.) col = vec3(0,1,0);
        //if(h < 0.) col = vec3(0,0,1);
        
        //col = mix(col, getColor(fragCoord.x/iResolution.x), step(abs(uv.y), .1));
         color = col;

         
        float4 ret = float4(color, 1.);
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
  


