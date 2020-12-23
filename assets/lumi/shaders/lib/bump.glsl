/*******************************************************
 *  lumi:shaders/lib/bump.glsl                         *
 *******************************************************
 *  Copyright (c) 2020 spiralhalo and Contributors.    *
 *  Released WITHOUT WARRANTY under the terms of the   *
 *  GNU Lesser General Public License version 3 as     *
 *  published by the Free Software Foundation, Inc.    *
 *******************************************************/

#ifndef VERTEX_SHADER
vec3 bump_normal(sampler2D tex, vec3 normal, vec2 uvn, vec2 uvt, vec2 uvb)
{
    vec3 tangentMove = l2_tangent;
    vec3 bitangentMove = l2_bitangent;

    vec4 texel     = texture2D(tex, uvn, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0);
    vec3 origin    = _bump_height(frx_luminance(texel.rgb)) * normal;

         texel     = texture2D(tex, uvt, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0);
    vec3 tangent   = tangentMove + _bump_height(frx_luminance(texel.rgb)) * normal - origin;
    
         texel     = texture2D(tex, uvb, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0);
    vec3 bitangent = bitangentMove + _bump_height(frx_luminance(texel.rgb)) * normal - origin;

    return normalize(cross(tangent, bitangent));
}
#endif
