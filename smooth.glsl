vec2 cSquare( in vec2 z )
{
    return vec2(
        z.x * z.x - z.y * z.y,
        2.0 * z.x * z.y
    );
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 c = fragCoord/iResolution.x;

    float scale = 4.0;

    c = c * scale - vec2(2.0, 1.0);

    vec3 weights = vec3(1.0,1.0,1.0);

    int maxIterations = 256;


    vec2 z = vec2(0, 0);

    for (int i = 0; i < maxIterations; i++)
    {
        vec2 oldz = z;
        z = cSquare(oldz) + c;

        if (dot(z, z) > 20.0)
        {
            float brightness = (float(i) - log2(log2(dot(z,z))) + 4) / float(maxIterations);
            
            fragColor = vec4(vec3(brightness) * weights, 1.0);
            break;
        } 
        else 
        {
            fragColor = vec4(0.0, 0.0, 0.0, 1.0);
        }
    }
}