
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

	//TODO: PART 1C

    vec3 normal = normalize(interpolatedNormal);
    vec3 view = normalize(view);
    vec3 lightVector = normalize(lightVector);
    vec3 h = normalize(view + lightVector);

	//AMBIENT
	vec3 light_AMB = ambientColor*kAmbient;


	//DIFFUSE
	float diffuse =  max(0.0,dot(normal, lightVector));
    vec3 intensity = lightColor* diffuse;
    vec3 light_DFF = intensity*kDiffuse;

	//SPECULAR
	vec3 tangent = normalize(cross(normal,vec3(0,1,0)));
	vec3 binormal = normalize(cross(normal,tangent));

    float dotLN = max(0.0,dot(lightVector,normal));



    if(dotLN < 0.0){

    vec3 light_SPC = vec3(0.0,0.0,0.0);
    vec3 TOTAL = light_AMB + light_DFF + light_SPC;
	gl_FragColor = vec4(TOTAL, 0.0);

    } else{

    float dotHT = dot(h,tangent)/(alphaX);
    float dotHB = dot(h,binormal)/(alphaY);

    float dotHN = max(0.0,dot(h,normal));
    float dotVN = max(0.0,dot(view,normal));

    float exponent = exp(-2.0*((dotHT*dotHT + dotHB*dotHB)/(1.0 + dotHN)));

	vec3 light_SPC = lightColor*kSpecular* sqrt(max(0.0,dotLN/dotVN))*exponent;
	vec3 TOTAL = light_AMB + light_DFF + light_SPC;
	gl_FragColor = vec4(TOTAL, 0.0);
    }

}