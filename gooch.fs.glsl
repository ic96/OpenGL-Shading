
uniform vec3 ambientColor;
uniform vec3 lightColor;
uniform float kAmbient;
uniform float kSpecular;
uniform float kDiffuse;
uniform float shininess;

varying float intensity;
varying vec3 lightVector;
varying vec3 interpolatedNormal;
varying vec3 view;
varying vec3 fragCoord;

void main() {

	//TOTAL INTENSITY
	//TODO PART 1D: calculate light intensity
	vec3 view = normalize(view);
	vec3 lightVector = vec3(normalize(lightVector));
    vec3 normal = normalize(interpolatedNormal);
    const float level = 5.0;
    const float scale = 1.0/level;
    vec3 h = normalize(view + lightVector);
   	vec4 resultingColor = vec4(0,0,0,0);


    // WARM AND COOL COLORS
    vec3 cool_color = vec3(159.0/255.0, 148.0/255.0, 255.0/255.0);
    vec3 warm_color = vec3(255.0/255.0, 0.0/255.0, 0.0/255.0);
    float cool_alpha = 0.25;
    float warm_alpha = 0.50;
    // DIFFUSE VECTOR
    float diffuse_coefficient =  max(0.0,dot(normal, lightVector));
    diffuse_coefficient = (1.0+diffuse_coefficient)/2.0;
    vec3 diffuse = diffuse_coefficient*floor(diffuse_coefficient*level)*scale*lightColor;

    vec3 cool = cool_color + vec3(1.0,0.0,1.0)*cool_alpha;
    vec3 warm = warm_color + vec3(1.0,0.0,1.0)*warm_alpha;
    vec3 mixColor = ((1.0+diffuse_coefficient)/2.0*cool + ((1.0-(1.0+diffuse_coefficient)/2.0))*warm);

    float silouette_edge = dot(normal, view);
    if(silouette_edge > 0.2){
    silouette_edge = 1.0;
    } else
    silouette_edge = 0.0;


    vec3 color = silouette_edge*mixColor;
    resultingColor = vec4(color*vec3(0.8,0.1,0.3), 1.0);


	gl_FragColor = resultingColor;
}
