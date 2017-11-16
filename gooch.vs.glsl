
uniform vec3 lightDir;
varying vec3 lightVector;
varying vec3 interpolatedNormal;
varying vec3 view;

void main() {

	// TODO: PART 1D

    view = -1.0*vec3(modelViewMatrix*vec4(position,1.0));
	interpolatedNormal = normalMatrix*normal;
	lightVector = vec3(viewMatrix*vec4(lightDir, 0.0));
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}