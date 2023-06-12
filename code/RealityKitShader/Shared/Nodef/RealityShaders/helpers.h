//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//


#ifndef helpers_h
#define helpers_h

float3 computeNormal(float2 p,float t,float warpType,float2 animVelocity,float angle,float screensize);

float fBMheightmapx(float2 p,float iTime, float warpType,float2 animVelocity,float angle);

//float4 fBMFlow(float2 pos, float2 sizeImage, float3 org, float iTime);

float4 fBMFlow(float2 pos, float2 sizeImage, float3 org, float iTime,float density = 120,float basicType=3, float colorType=2.0 );

#endif /* helpers_h */
