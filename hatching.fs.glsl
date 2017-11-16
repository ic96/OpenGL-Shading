
uniform vec3 ambientColor;
uniform vec3 lightColor;
uniform float kAmbient;
uniform float kSpecular;
uniform float kDiffuse;
uniform float shininess;
uniform float alphaX;
uniform float alphaY;
varying vec3 view;
varying vec3 interpolatedNormal;
varying vec3 lightVector;



void main() {
	vec3 view = normalize(view);
	vec3 lightVector = vec3(normalize(lightVector));
    vec3 normal = normalize(interpolatedNormal);
    const float level = 5.0;
    const float scale = 1.0/level;
    vec3 h = normalize(view + lightVector);


    // DIFFUSE VECTOR
    float diffuse_coefficient =  max(0.0,dot(normal, lightVector));
    float intensity = dot(normal,lightVector);

    float silouette_edge = dot(normal, view);
    if(silouette_edge > 0.2){
    silouette_edge = 1.0;
    } else
    silouette_edge = 0.0;


    gl_FragColor = vec4(1.0,1.0,1.0,1.0)*silouette_edge;
   	//TODO PART 1D: change resultingColor to silhouette objects
    if (intensity < 1.0)
    {
       // hatch from left top corner to right bottom
       if (mod(gl_FragCoord.x + gl_FragCoord.y, 10.0) == 0.0)
       {
          gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0)*silouette_edge;
       }
    }

    if (intensity < 0.75)
    {
       // hatch from right top corner to left boottom
       if (mod(gl_FragCoord.x - gl_FragCoord.y, 10.0) == 0.0)
       {
          gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0)*silouette_edge;
       }
    } else if (intensity < 0.5)
    {
       // hatch from left top to right bottom
       if (mod(gl_FragCoord.x - gl_FragCoord.y - 5.0, 10.0) == 0.0)
       {
          gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0)*silouette_edge;
       }
    } else if (intensity< 0.3)
    {
       // hatch from right top corner to left bottom
       if (mod(gl_FragCoord.x - gl_FragCoord.y - 5.0, 10.0) == 0.0)
       {
          gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0)*silouette_edge;
        }
       }

}