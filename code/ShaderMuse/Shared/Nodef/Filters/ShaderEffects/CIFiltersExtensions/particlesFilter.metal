//
//  Copyright © 2022 James Boo. All rights reserved.
//

//the random position and velocity of the following is chnaged

//randomPositionVal2mod -- also variable mod changed to 0,0 to speed up
//randomVelocityVal0mod -- also variable mod changed to 0,0 to speed up
//randomVelocityVal1mod
//other velocity types not chnaged ... val2,val3,etc
//note using texture noise might mean the temporal effect is gone
//becuase each frame , the random number is different
//just optimized spped for 1 frame

#include <metal_stdlib>
using namespace metal;


#include <CoreImage/CoreImage.h> // includes CIKernelMetalLib.h
#define PI 3.1416
//#define blendtype 0 //0 normal ... 1 geometric

extern "C" { namespace coreimage {

    
    #define nParticles    60
    #define nClusters    4

   
    //Noise
    //https://www.shadertoy.com/view/Msf3WH
    
    float2 hash( float2 p ) // replace this by something better
    {
        p = float2( dot(p,float2(127.1,311.7)), dot(p,float2(269.5,183.3)) );
        return -1.0 + 2.0*fract(sin(p)*43758.5453123);
    }
    
    float noiseX(float2 p )
    {
        
        //return 0;
        
        const float K1 = 0.366025404; // (sqrt(3)-1)/2;
        const float K2 = 0.211324865; // (3-sqrt(3))/6;

        float2  i = floor( p + (p.x+p.y)*K1 );
        float2  a = p - i + (i.x+i.y)*K2;
        float m = step(a.y,a.x);
        float2  o = float2(m,1.0-m);
        float2  b = a - o + K2;
        float2  c = a - 1.0 + 2.0*K2;
        float3  h = max( 0.5-float3(dot(a,a), dot(b,b), dot(c,c) ), 0.0 );
        
        float3  n = h*h*h*h*float3( dot(a,hash(i+0.0)), dot(b,hash(i+o)), dot(c,hash(i+1.0)));
        return dot( n, float3(70.0) );
        
       
    }

     
    float noiseY(float2 p )
    {
        //return 0.5;
        
        const float K1 = 0.356027404; // (sqrt(3)-1)/2;
        const float K2 = 0.216324805; // (3-sqrt(3))/6;

        float2  i = floor( p + (p.x+p.y)*K1 );
        float2  a = p - i + (i.x+i.y)*K2;
        float m = step(a.y,a.x);
        float2  o = float2(m,1.0-m);
        float2  b = a - o + K2;
        float2  c = a - 1.0 + 2.0*K2;
        float3  h = max( 0.5-float3(dot(a,a), dot(b,b), dot(c,c) ), 0.0 );
        
        float3  n = h*h*h*h*float3( dot(a,hash(i+0.0)), dot(b,hash(i+o)), dot(c,hash(i+1.0)));
        return dot( n, float3(70.0) );
    }
    
    
    //ver 2.0
    float3 noiseSampling(float2 uv,sampler sourceImage)
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
   
    
    float gaussian(float col, float dist, float std)
    {
        float numer = -dist*dist;
        float denom = 2*std*std;
        float exponent = numer/denom;
        return col*exp(exponent);
    }

    
    
    float3 gaussian3(float3 colors, float3 dist, float std)
    {
        //float rr=gaussian(colors.r,dist.x,std);
        //float gg=gaussian(colors.g,dist.y,std);
        //float bb=gaussian(colors.b,dist.z,std);
        //return float3(rr,gg,bb);
        
        float3 numer = -dist*dist;
        float denom = 2*std*std;
        float3 exponent = numer/denom;
        return colors*exp(exponent);
        
       
    }
   

   
    float2 randomPositionVal(sampler sourceImage, float2 prevPosition)
    {
        
        float2 position = noiseSampling(prevPosition,sourceImage).xy;
        position = position * 2.0 - 1.0;
        return position;
        
        /*
        float positionX= noiseX(prevPosition);
        float positionY= noiseY(prevPosition);
        float2 position = float2(positionX,positionY);
        return position;
         */
        
    }
    
    float2 randomPositionVal2mod(sampler sourceImage,float2 prevPosition,int offset)
    {
        
        
        float2 mod =  float2(0.0,0.0);
        //float2 mod =  noiseSampling(prevPosition,sourceImage).xy;
        
        float2 position = noiseSampling(prevPosition*(offset+ prevPosition*0.421),sourceImage).xy+mod*float2(0.1452,0.1022);
        
        position = position * 2.0 - 1.0;
        
        return position;
        
        /*
        float modx = noiseX( prevPosition);
        float mody = noiseY( prevPosition);
        
        
        float positionX = noiseX(prevPosition*(offset+ prevPosition.x*0.421))+mody*0.1452;
        float positionY = noiseY(prevPosition*(offset+ prevPosition.y*0.245))+modx*0.1022;
        float2 position = float2(positionX,positionY);
        return position;
         */
        
        
        
    }
    
    float2 randomPositionVal2(float2 prevPosition,int offset)
    {
        
       
        float modx = noiseX( prevPosition);
        float mody = noiseY( prevPosition);
        
        
        float positionX = noiseX(prevPosition*(offset+ prevPosition.x*0.421))+mody*0.1452;
        float positionY = noiseY(prevPosition*(offset+ prevPosition.y*0.245))+modx*0.1022;
        float2 position = float2(positionX,positionY);
        return position;
         
        
        
        
    }
    
    
    
    float2 getParticlePosition(float2 initial, float2 velocity, float time)
    {
        return initial+velocity*time;
    }
    
    float2 getParticlePositionAcc(float2 initial, float2 velocity, float time, float2 constacc=float2(-0.043,-0.02))
    {
        //float2 constacc = float2(-0.043,-0.02);
        return initial+velocity*time+constacc*time*time;
    }
   
    
    float ComputeClusterTime(float2 rand,float iTime, float forwardFactor, float reverseFactor)
    {
        //Compute Cluster Time using remainder
        //float forwardFactorReduce = forwardFactor/(4.0+rand.y);
        //float reverseFactorReduce = reverseFactor/(4.0+rand.x);
        
        float forwardFactorReduce = forwardFactor/(2.001);
        float reverseFactorReduce = reverseFactor/(2.003);
        
        
        float divider = (forwardFactor*(rand.y+1.0));
        float quotient = int((iTime*forwardFactorReduce) /  divider);
        float mainInt = divider * quotient;
        float t = (iTime*reverseFactorReduce) - mainInt;
        
        return t;
        
    }
   
    
    
    ///
    
    /*
    float2 randomVelocityVal0(float2 initVelocity, float2 prevVelocity,int offset,float2 vscaling=float2(0.145256,.4022))
    {
        
        float modx = noiseX(prevVelocity);
        float mody = noiseY(prevVelocity);
        
        float velocityX = noiseX(initVelocity*(offset+prevVelocity.x*vscaling.x))+modx*vscaling.x;
        float velocityY = noiseY(initVelocity*(offset+prevVelocity.y*vscaling.x))+mody*vscaling.y;
        float2 velocity = float2(velocityX,velocityY);
        return velocity;
        
        
        
    }
     */
    
    //ver 2.0
    float2 randomVelocityVal0mod(sampler sourceImage,float2 initVelocity, float2 prevVelocity,int offset,float2 vscaling=float2(0.145256,.4022))
    {
    
        
        float2 mod = float2(0.0,0.0);
        
       // float2 mod = noiseSampling( prevVelocity,sourceImage).xy;
        
        float2 velocity = noiseSampling(initVelocity*(offset+prevVelocity*vscaling.x),sourceImage).xy+mod*vscaling.x;
        
       
        
        velocity = velocity * 2.0 - 1.0;
        
        return velocity;

        
        /*
        float velocityX =* noiseX(initVelocity*(offset+prevVelocity.x*vscaling.x))+mod.x*vscaling.x;
        float velocityY = noiseY(initVelocity*(offset+prevVelocity.y*vscaling.x))+mod.y*vscaling.y;
        float2 velocity = float2(velocityX,velocityY);
        return velocity;
         */
        
        
    }
    
    float2 randomVelocityVal1mod(sampler noiseImage, float2 initVelocity, float2 prevVelocity,int offset,float2 vscaling=float2(0.145256,.4022))
    {
        float2 mod = noiseSampling( prevVelocity,noiseImage).xy;
       
        float2 velocity = noiseSampling(initVelocity*(offset+prevVelocity*float2(vscaling.x,0.135256)),noiseImage).xy+mod*vscaling;;
                            
        velocity = velocity * 2.0 - 1.0;
        
        return velocity;
                             
        /*
        float modx = noiseX(prevVelocity);
        float mody = noiseY(prevVelocity);
        
        float angle=(240.0/180.0)*PI;
        
        float velocityX = noiseX(initVelocity*(offset+prevVelocity.x*vscaling.x))+modx*vscaling.x;
        float velocityY = cos(angle)*noiseX(initVelocity*(offset-prevVelocity.y*0.135256))+mody*vscaling.y;
        float2 velocity = float2(velocityX,velocityY);
        return velocity;
        */
        
        
    }
    
    
    /*
     //consideration
    float2 randomVelocityVal1(float2 initVelocity, float2 prevVelocity,int offset,float2 vscaling=float2(0.145256,.4022))
    {
        
        float modx = noiseX(prevVelocity);
        float mody = noiseY(prevVelocity);
        
        float angle=(240.0/180.0)*PI;
        
        float velocityX = noiseX(initVelocity*(offset+prevVelocity.x*vscaling.x))+modx*vscaling.x;
        float velocityY = cos(angle)*noiseX(initVelocity*(offset-prevVelocity.y*0.135256))+mody*vscaling.y;
        float2 velocity = float2(velocityX,velocityY);
        return velocity;
        
        
        
    }
   */
   
   
    float2 randomVelocityVal2(float2 initVelocity, float2 prevVelocity,int offset,float2 vscaling=float2(0.145256,.4022))
    {
        float angleoffset =(float(offset)/float(nParticles))*2*PI;
        float2 angleratio = float2(cos(angleoffset),sin(angleoffset));
        angleoffset *= 1.2;
        
        //prevVelocity+=prevVelocity;
        float velocityX = noiseX(angleratio+prevVelocity);
        float velocityY = noiseY(angleratio.yx + initVelocity);
        float2 velocity = float2(velocityX,velocityY);
        //return velocity;
         
        
        //return angleratio;
        return angleratio+velocity;
    }
    
    
    
    
    
     float2 randomVelocityVal3(float2 initVelocity, float2 prevVelocity,int offset,float2 vscaling=float2(0.145256,.4022),int clusterNum=0)
    {
        float angleoffset =(float(offset)/float(nParticles));
        angleoffset += offset/2.0;
        //float angleoffset =(float(offset)/float(nParticles))*2*PI;
        float2 angleratio = float2(cos(angleoffset+0.123),sin(angleoffset+0.456));
        
        //float modx = sin(clusterNum*0.5)*0.01;
        //float mody = cos(clusterNum*0.5)*0.01;
        float modx = 0;
        float mody = 0;
        
        float velocityX = noiseX(angleratio);
        float velocityY = noiseY(angleratio.yx);
        //float velocityY = noiseY(angleratio.yx+angleratio);
        //float2 velocity = float2(velocityX,velocityY);
        float2 velocity = float2(velocityX+modx,velocityY+mody);
        return velocity;
         
        
        //return sqrt(angleratio*angleratio*velocity*velocity);
        
    }
     
    float2 randomVelocityGeneric(sampler noiseImage,float2 initVelocity, float2 prevVelocity,int offset, int type=0,float2 vscaling=float2(0.145256,.4022),int clusterNum=0)
    {
        
        //vscaling only for type 0,1,2,3
        if (type==0)
            return  randomVelocityVal0mod( noiseImage,initVelocity,  prevVelocity, offset,vscaling);
        else if (type==1)
            return  randomVelocityVal0mod( noiseImage, initVelocity,  prevVelocity, offset,vscaling);
        else if (type==2)
            return  randomVelocityVal0mod(noiseImage, initVelocity,  prevVelocity, offset,vscaling);
        else if (type==3)
            return  randomVelocityVal1mod( noiseImage, initVelocity,  prevVelocity, offset,vscaling);
        else if (type==4)
            return  randomVelocityVal2( initVelocity,  prevVelocity, offset,vscaling);
        else if (type==5)
            return  randomVelocityVal3( initVelocity,  prevVelocity, offset,vscaling,clusterNum);
        else
            return  randomVelocityVal0mod( noiseImage, initVelocity,  prevVelocity, offset,vscaling);
        
    }
    
    
    float3 Particles(sampler noiseImage, float2 uv,float iTime, float3 initialColor, float std, bool varyColor=false, int noisetype=0,float2 initvelocity= float2(0.5089, 0.1501),float2 initcolormod= float2(0.3061, 0.2403),float2 initlocation = float2(0.45, 0.5),float2 vscaling=float2(0.145256,.4022), float2 acc=float2(-0.043,-0.02),float2 timescaling = float2(5.0,5.0))
    {
        float3 color = float3(0., 0., 0.);
        
        float2 location = initlocation;
        for(int i = 0; i < nClusters; i++)
        {
            float t = ComputeClusterTime(location,iTime,timescaling.x,timescaling.y);
            //float t = ComputeClusterTime(location,iTime,5.0,4.5);
            //float t = ComputeClusterTime(location,iTime,4.0,3.26);
           
            //location =randomPositionVal(location);
            
            location = randomPositionVal2mod(noiseImage,location,i);
           
            //location = randomPositionVal2(location,i);
           
          
            
            //float2 initvelocity = float2(0.5089, 0.1501);
            //float2 initcolormod = float2(0.3061, 0.2403);
            for(int j = 0; j < nParticles; j++)
            //for(int j = 0; j < 100; j++)
            {
                int modj = (j*j)%nParticles;
                int usej = j;
                //int usej = modj; //streaming particles
                //if (noisetype>0)
                 //   usej = modj;
                float2 velocity = initvelocity;
                velocity = randomVelocityGeneric( noiseImage, initvelocity,velocity,usej,noisetype,vscaling,i);
                float2 colormod = initcolormod;
                colormod = randomVelocityVal0mod( noiseImage,initcolormod,colormod,modj,vscaling);
               
                
                float2 current = getParticlePositionAcc(location, velocity,  t,acc);
               
                //org
                float dist1 = sqrt(abs(dot(uv-current,uv-current)));
                float dist2 = dist1;
                float dist3 = dist1;
             
                
                //sized  particles?
                //float dist1 = sqrt(abs(dot(3.7*(uv-current),1.2*(uv-current))));
                //elliptical gaussian
                if (noisetype==2)
                {
                    
                    if (j%2==1)
                    {
                        dist2 = sqrt(0.532*(uv-current).x * (uv-current).x + 0.92*(uv-current).y * (uv-current).y)*1.5;
                        dist1 = dist2;
                        dist3 = dist2;
                    }
                    else
                    {
                        dist1 = sqrt(0.532*(uv-current).x * (uv-current).x + 0.92*(uv-current).y * (uv-current).y)*1.5;
                    }
                      
                    
                    //dist3 = sqrt(0.532*(uv-current).y * (uv-current).y + 0.92*(uv-current).x * (uv-current).x)*1.5;
                    
                }
                
                //dist1 = sqrt(abs(dist1));
                
                //float dist2 = sqrt(abs(dot(uv-current,uv-current)));
                //float dist3 = sqrt(abs(dot(uv-current,uv-current)));
               
                if (varyColor)
                {
                    //dist1 = sqrt(dist1)*dist1 ;
                    //dist1 = sqrt(dist1);
                    dist1 = dist1;
                    dist2 = dist2 * 0.7523 / colormod.x;
                    dist3 = dist3* 0.7019 / colormod.y;
                    
                    if (noisetype==2)
                    {
                        dist1 = dist1 * 0.72134/sin(2*PI*velocity.x);
                        dist2 = dist2 * 0.53221 ;
                        dist3 = dist3* 0.894373/cos (2*PI*velocity.y);
                    }
                    else if (noisetype==3)
                    {
                        dist1 = dist1 * 0.75/sin(2*PI*velocity.x);
                        dist2 = dist2 ;
                        dist3 = dist3* 0.7/cos (2*PI*velocity.y);
                    }
                    else if (noisetype==4)
                    {
                        dist1 = dist1 * 0.72134/cos(2.422*PI*velocity.x);
                        dist2 = dist2 * 0.833221 ;;
                        dist3 = dist3* 0.793224/cos (2.633*PI*velocity.y);
                    }
                    else if (noisetype==5)
                    {
                        dist1 = dist1 * 0.72134/cos(2.422*PI*velocity.x);
                        dist2 = dist2 * 0.793224/cos (2.633*PI*velocity.y);
                        dist3 = dist3* 0.8934;
                    }
                }
               
                
                
                //
                if (noisetype==3)
                {
                    color += gaussian3(initialColor, float3(dist1,dist2,dist3), std);
                }
                else
                {
                    //varying std, particles gets smaller
                    color += gaussian3(initialColor, float3(dist1,dist2,dist3), std*(1.0-(float(j)/float(nParticles*2.0156))));
                }
                
                
            }
        }
        
        //contours
        //float3 v = cos(color*12.*3.1415);
        //return v;
        
        return color;
    }
    
    
  
    
    
    //ver 1.1
    float4 particlesFilter(sampler sourceImage,sampler noiseImage, float animType, float factor, float angle, float iTime,float2 initvelocity,float2 initcolormod,float2 initlocation ,float2 vscaling, float2 acc,float2 timescaling) {

        
        float2 pos = sourceImage.coord();
        float2 sizeImage = sourceImage.size();
        float3 org = sourceImage.sample(pos).rgb;
    
        
        //////
     
        float2 uv = float2(pos.x,pos.y);
        float2 p = 2. * uv - 1;
        p.x *= sizeImage.x / sizeImage.y;
          
        int  noisetype =  int(animType);
        bool varyColor = true;
        bool varyColorPowder = false;
        //if ((noisetype==3) || (noisetype==4) || (noisetype==5))
        //if (noisetype>=2)
        if (noisetype>=1)
            varyColorPowder = true;
        
        float3 color = float3(0,0,0);
        if ((noisetype==0) || (noisetype>1))
        //if (type==0)
        {
            //High freq
            color = Particles( noiseImage,p,iTime,float3(1.0,1.0,1.0),0.015,varyColor,noisetype,initvelocity,initcolormod,initlocation,vscaling,acc,timescaling);
        }
        else //if (type==1)
        {
            //powder alternative
            color = Particles( noiseImage,p,iTime,float3(0.025,0.02,0.02),0.15,varyColor,noisetype,initvelocity,initcolormod,initlocation,vscaling,acc,timescaling);
        }
        
        //Blending I
        color = color*0.3 + org*0.7; //blending
             
        
        //Low freq
        float3 color2 = Particles( noiseImage,p,iTime,float3(0.025,0.02,0.02),0.2,varyColorPowder,noisetype,initvelocity,initcolormod,initlocation,vscaling,acc,timescaling);
        
        //Blending II
        color2 = color2*1.2;
        float3 orgcolor2 = color2;
        
        color2 = max(color2,color);
        
        
        //alt blend mode
        /*
        if ((color2.r==color.r) && (color2.g==color.g) && (color2.b==color.b))
        {
            //if org color2 is darker
            //color = sqrt(sqrt(color2 * color2 * color2 * color));
            color = sqrt(sqrt((orgcolor2+(0.37532*color)) * color * color * color));
        }
        else
            color = sqrt(sqrt(color2 * color2 * color * color));
         */
        color = sqrt(sqrt((orgcolor2+(0.7532*color)) * color * color * color));
        
        //org
        //color = sqrt(sqrt(color2 * color2 * color * color));
        
        //color = sqrt(sqrt(color * color * org * org));
        
        
        
        float4 ret = float4(color, 1.);
        return ret;
    }
    
    
  

}}
  
