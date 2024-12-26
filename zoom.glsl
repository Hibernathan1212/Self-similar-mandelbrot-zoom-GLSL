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

    float scale = 1.0/(exp(0.2 * iTime));

    c = c * scale - vec2(0.177495, 0.834551);

    vec3 weights = 2.0 * vec3(4.0, 2.0, 6.0);

    int maxIterations = int(5.0 * iTime * iTime) + 1000;

    vec2 z = vec2(0, 0);

    for (int i = 0; i < maxIterations; i++)
    {
        vec2 oldz = z;
        z = cSquare(oldz) + c;

        if (dot(z, z) > 4.0)
        {
            float brightness = float(i) / (float(maxIterations) * sqrt(iTime + 1.0));
            
            fragColor = vec4(vec3(brightness) * weights, 1.0);
            break;
        } 
        else 
        {
            fragColor = vec4(0.0, 0.0, 0.0, 1.0);
        }
    }
}