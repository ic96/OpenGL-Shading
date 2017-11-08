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

	//TODO: PART 1B

    vec3 normal = normalize(interpolatedNormal);
    vec3 view = normalize(view);
    vec3 lightVector = normalize(lightVector);

	//AMBIENT
	vec3 light_AMB = kAmbient*ambientColor;

	//DIFFUSE
	float diffuse =  max(0.0,dot(normal, lightVector));
    vec3 intensity = lightColor* diffuse;
	vec3 light_DFF = intensity*kDiffuse;

	//SPECULAR
    vec3 h = normalize(view + lightVector);

	vec3 light_SPC = lightColor*kSpecular*pow(max(0.0,dot(h,normal)), shininess);

	//TOTAL
	vec3 TOTAL = light_AMB + light_DFF + light_SPC;
	gl_FragColor = vec4(TOTAL, 0.0);

}