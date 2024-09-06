vec2 hash( in vec2 x )
{
    const vec2 k = vec2( 0.3183099, 0.3678794 );
    x = x * k + k.yx;
    return -1.0 + 2.0 * fract(16.0 * k * fract( x.x * x.y * (x.x + x.y)));
}

vec2 hash22(vec2 p) {
    // credit to Dave_Hoskins - https://www.shadertoy.com/view/4djSRW
	vec3 p3 = fract(vec3(p.xyx) * vec3(.1031, .1030, .0973));
    p3 += dot(p3, p3.yzx+33.33);
    return fract((p3.xx+p3.yz)*p3.zy);
}

vec3 noised( in vec2 p )
{
    vec2 i = floor( p );
    vec2 f = fract( p );

    vec2 u = f*f*f*(f*(f*6.0-15.0)+10.0);
    vec2 du = 30.0*f*f*(f*(f-2.0)+1.0);

    vec2 ga = hash( i + vec2(0.0, 0.0) );
    vec2 gb = hash( i + vec2(1.0, 0.0) );
    vec2 gc = hash( i + vec2(0.0, 1.0) );
    vec2 gd = hash( i + vec2(1.0, 1.0) );

    float va = dot( ga, f - vec2(0.0, 0.0) );
    float vb = dot( gb, f - vec2(1.0, 0.0) );
    float vc = dot( gc, f - vec2(0.0, 1.0) );
    float vd = dot( gd, f - vec2(1.0, 1.0) );

    return vec3( va + u.x*(vb-va) + u.y*(vc-va) + u.x*u.y*(va-vb-vc+vd),
        		 ga + u.x*(gb-ga) + u.y*(gc-ga) + u.x*u.y*(ga-gb-gc+gd) +
        		 du * (u.yx*(va-vb-vc+vd) + vec2(vb,vc) - va));
}