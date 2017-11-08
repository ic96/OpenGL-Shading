
uniform vec3 ambientColor;
uniform vec3 lightColor;
uniform float kAmbient;
uniform float kSpecular;
uniform float kDiffuse;
uniform float shininess;
varying vec3 view;
varying vec3 interpolatedNormal;
varying vec3 lightVector;

void main() {

	//TODO: PART 1A

    vec3 normal = normalize(interpolatedNormal);
    vec3 view = normalize(view);
    vec3 lightVector = normalize(lightVector);
    vec3 bounce = 2.0*normal*max(0.0,dot(lightVector,normal)) - lightVector;

    // DIFFUSE VECTOR
    float diffuse =  max(0.0,dot(normal, lightVector));
    vec3 intensity = lightColor* diffuse;

	//AMBIENT
	vec3 light_AMB = ambientColor*kAmbient;

	//DIFFUSE
	vec3 light_DFF = intensity*kDiffuse;


	//SPECULAR
    vec3 light_SPC = lightColor*kSpecular*pow(max(0.0,dot(view,bounce)), shininess);

	//TOTAL
	vec3 TOTAL = light_AMB + light_DFF + light_SPC;
	gl_FragColor = vec4(TOTAL, 0.0);

}