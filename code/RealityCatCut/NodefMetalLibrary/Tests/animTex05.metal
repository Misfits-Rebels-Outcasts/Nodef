//
//  Copyright © 2022 James Boo. All rights reserved.
//



//Based on : https://www.shadertoy.com/view/wsBXDt
//Rnadom Tiled Pattern


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
    
    #define NUM_OCTAVES5 5
    #define sstep(sf, d) (1. - smoothstep(0., sf, d))
    
    //ver 3.0
    float2x2 rotateMatrix60(float theta)
    {
        float c = cos(theta);
        float s = sin(theta);
        return float2x2(c,-s,s,c);
        
    }
    
    
    // IQ's standard vec2 to float hash formula.
    float hash21_60(float2 p){
     
        float n = dot(p, float2(127.183, 157.927));
        return fract(sin(n)*43758.5453);
    }
    
    // Cheap and nasty 2D smooth noise function with inbuilt hash function -- based on IQ's
    // original. Very trimmed down. In fact, I probably went a little overboard. I think it
    // might also degrade with large time values.
    float n2D(float2 p) {

        float2 i = floor(p); p -= i; p *= p*(3. - p*2.);
        
        float2 vx = float2(1, 113);
        float2 px = float2(1. - p.y, p.y);
        float2 py = float2(1. - p.x, p.x);
        float4 vz = float4(0, 1, 113, 114);
        float ix = dot(i, vx);
        float4 sx = fract(sin(vz + ix)*43758.5453);
        float2x2 mat = float2x2(sx.x,sx.y,sx.z,sx.w);
        float rx = dot(mat*px,py);
        return rx;
                   
        //return dot(mat2(sx)*
         //               vec2(1. - p.y, p.y), vec2(1. - p.x, p.x) );

             
    }
    
    
    // FBM -- 4 accumulated noise layers of modulated amplitudes and frequencies.
    float fbm60(float2 p)
    { return n2D(p)*.533 + n2D(p*2.)*.267 + n2D(p*4.)*.133 + n2D(p*8.)*.067; }

    // Distance field for the grid tile.
    float TilePattern(float2 p){
        
         
        float2 ip = floor(p); // Cell ID.
        p -= ip + .5; // Cell's local position. Range [vec2(-.5), vec2(.5)].
        
         
        // Using the cell ID to generate a unique random number.
        float rnd = hash21_60(ip);
        float rnd2 = hash21_60(ip + 27.93);
        //float rnd3 = hash21(ip + 57.75);
         
        // Random tile rotation.
        float iRnd = floor(rnd*4.);
        p = rotateMatrix60(iRnd*3.14159/2.)*p;
        // Random tile flipping.
        //p.y *= (rnd>.5)? -1. : 1.;
        
        
        // Rendering the arcs onto the tile.
        //
        float d = 1e5, d1 = 1e5, d2 = 1e5, d3 = 1e5, l;
        
       
        // Three top left arcs.
        l = length(p - float2(-.5, .5));
        d1 = abs(l - .25);
        d2 = abs(l - .5);
        d3 = abs(l - .75);
        if(rnd2>.33) d3 = abs(length(p - float2(.125, .5)) - .125);
        
        d = min(min(d1, d2), d3);
        
        // Two small arcs on the bottom right.
        d1 = 1e5;//abs(length(p - vec2(.5, .5)) - .25);
        //if(rnd3>.35) d1 = 1e5;//
        d2 = abs(length(p - float2(.5, .125)) - .125);
        d3 = abs(length(p - float2(.5, -.5)) - .25);
        d = min(d, min(d1, min(d2, d3)));
        
        
        // Three bottom left arcs.
        l = length(p + .5);
        d = max(d, -(l - .75)); // Outer mask.
        
        // Equivalent to the block below:
        //
        //d1 = abs(l - .75);
        //d2 = abs(l - .5);
        //d3 = abs(l - .25);
        //d = min(d, min(min(d1, d2), d3));
        //
        d1 = abs(l - .5);
        d1 = min(d1, abs(d1 - .25));
        d = min(d, d1);
        
        
        // Arc width.
        d -= .0625;
        
     
        // Return the distance field value for the grid tile.
        return d;
        
    }

    
    // Smooth fract function.
    float sFract(float x, float sf){
        
        x = fract(x);
        return min(x, (1. - x)*x*sf);
        
    }

    // The grungey texture -- Kind of modelled off of the metallic Shadertoy texture,
    // but not really. Most of it was made up on the spot, so probably isn't worth
    // commenting. However, for the most part, is just a mixture of colors using
    // noise variables.
    float3 GrungeTex(float2 p){
        
         // Some fBm noise.
        //float c = n2D(p*4.)*.66 + n2D(p*8.)*.34;
        float c = n2D(p*3.)*.57 + n2D(p*7.)*.28 + n2D(p*15.)*.15;
       
        // Noisey bluish red color mix.
        float3 col = mix(float3(.25, .1, .02), float3(.35, .5, .65), c);
        // Running slightly stretched fine noise over the top.
        col *= n2D(p*float2(150., 350.))*.5 + .5;
        
        // Using a smooth fract formula to provide some splotchiness... Is that a word? :)
        col = mix(col, col*float3(.75, .95, 1.2), sFract(c*4., 12.));
        col = mix(col, col*float3(1.2, 1, .8)*.8, sFract(c*5. + .35, 12.)*.5);
        
        // More noise and fract tweaking.
        c = n2D(p*8. + .5)*.7 + n2D(p*18. + .5)*.3;
        c = c*.7 + sFract(c*5., 16.)*.3;
        col = mix(col*.6, col*1.4, c);
        
        // Clamping to a zero to one range.
        return clamp(col, 0., 1.);
        
    }

   
    
    //ver 1.1
    float4 animTex05Filter(sampler inputImage, sampler sampledImage, float animType, float inputAuraMask, float angle, float iTime,float3 inputColor, float sampletype=0.0) {

        
        //currently text / mask image have to be same size as fbm inputimage
        float2 pos = sampledImage.coord();
        float2 sizeImage = inputImage.size();
        //float3 org = inputImage.sample(pos).rgb;
        
        //float3 mask = noiseSamplesReverse(pos, inputMask);
        //float3 maskExtend = noiseSamplesReverse(pos, inputMaskExtend);
    
       
     
        //float2 uv = float2(pos.x,pos.y);
        //float2 p = uv-0.5;
        //p.x *= sizeImage.x / sizeImage.y;
      
        //Actual
        //float3 color = float3(0,0,0);
        
        // Aspect correct screen coordinates. Setting a minumum resolution on the
            // fullscreen setting in an attempt to keep things relatively crisp.
        float res = min(sizeImage.y, 750.0);
        float2 uv = (pos*sizeImage.xy - sizeImage.xy*0.5)/res;
            
        //float scale = 4.0;
        // Scaling and translation.
        //float2 p = uv*4. + float2(1, 0)*iTime;
       
        //float2 p = uv*scale+ float2(1, 0)*iTime;
       
        // Optional rotation, if you'd prefer.
        float2 p = rotateMatrix60(3.14159/6.)*uv*4. + float2(1, 0)*iTime;
        //float2 p = rotateMatrix60(3.14159/3.)*uv*scale + float2(0.2, 0)*iTime*scale/1000.0;
        
        
        
        // Flockaroo's rotozoom suggestion, if that's more your speed. :)
        //vec2 p = rot2(sin(iTime/4.)*3.14159)*uv*(4.5 + 1.5*sin(iTime/4.)) + vec2(0, 1)*iTime;
        
            
        // Taking a few distance field readings.
        float2 eps = float2(4, 6)/sizeImage.y;
        float d = TilePattern(p); // Initial field value.
        float d2 = TilePattern(p + eps); // Slight sample distance, for highlighting,.
        float dS = TilePattern(p + eps*3.); // Larger distance, for shadows.
        
        // Calculating the sample difference.
        float b = smoothstep(0., 15./450., d - .015);
        float b2 = smoothstep(0., 15./450., d2 - .015);
        
        // Bump value for the warm highlight (above), and the cool one (below).
        float bump = max(b2 - b, 0.)/length(eps);
        float bump2 = max(b - b2, 0.)/length(eps);
            
         
            
        // Smoothing factor, based on resolution.
        float sf = 5./sizeImage.y;
         
        // The grungey texture.
        float3 tx = GrungeTex(p/4. + .5);
        tx = smoothstep(0., .5, tx);
        
             
        // Background texture.
        float3 bg = tx*float3(.85, .68, .51);
       
        // Initiate the image color to the background.
        float3 col = bg;
        
        

        /*
        // Displaying the grid, in order to see the individual grid tiles.
        #ifdef SHOW_GRID
        vec2 q = abs(fract(p) - .5);
        float gw = .0275;
        float grid = (max(q.x, q.y) - .5 + gw);
        col = mix(col, vec3(0), (smoothstep(0., sf*4., grid - gw + gw*2.))*.75);
        col = mix(col, bg*2., (smoothstep(0., sf, grid - gw + gw/2.)));
        #endif
        */
             
        // Sometimes, more detail can help, but in this case, it's a bit much, I think. :)
        //float dP = TilePattern(p*5.);
        //col = mix(col, min(bg*2.5, 1.), sstep(sf*15., dP + .01)); // Pattern.
        //col = mix(col, bg/4., sstep(sf*5., dP + .03)); // Pattern.
         
        
        // TILE RENDERING.
        
        // Drop shadow -- blurred and slighly faded onto the background.
        col = mix(col, float3(0), sstep(sf*4., dS - .02)*.75); // Shadow.
        
        // Blurred line -- subtle, and not entirely necessary, but it's there.
        col = mix(col, float3(0), sstep(sf*8., d)*.35);
        
        // Dark edge line -- stroke.
        col = mix(col, float3(0), sstep(sf, d));
         
            
        // Pattern color -- just a brightly colored version of the background.
        float3 pCol = float3(2.5, .75, .25)*tx;
        // Uncomment this, if blue's more your thing.
        //pCol = pCol.zyx*1.2;
        
      
        // Apply the pattern color. Decrease the pattern width by the edge line width.
        col = mix(col, pCol, sstep(sf, d + .025));
         
            
        // Use some noise to mix the colors from orange to pink. Uncomment to see what it does.
        col = mix(col, col.xzy, smoothstep(.3, 1., fbm60(p*.85))*.7);
        
        // Applying the warm sunlight bump value to the image, on the opposite side to the shadow.
        col = col + (float3(1, .2, .1)*(bump*.01 + bump*bump*.003));
        // Applying the cool bump value to the image, on the shadow side.
        col = col + col*(float3(1, .2, .1).zyx*(bump2*.01 + bump2*bump2*.003));
     
            
        // Uncomment this to see the grungey texture on its own. Yeah, it's pretty basic,
        // so it won't be winning any awards, but it's suitable enough for this example. :)
        //col = tx;

        
        // Rough gamma correction.
        float4 fragColor = float4(sqrt(max(col, 0.)), 1);

         
        float4 ret = fragColor;
        //float4 ret = float4(color,1.0);
        
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
  


