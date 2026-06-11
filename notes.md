## Tips
- Variables in @tool scripts (like HexConst) are ephemeral. They get set to the value in the script on editor start an can be changed via code (e.g. HexConstModifier). They will be lost (= reset to the value specified in code) upon editor restart. Modify them for testing but safe the correct values somewhere!


## TODO
- detect stuck enemies
- align trerrain-gen with nav-mesh capabilities
  - improve smooth edges.
    - Take neighbour hex into account?
    - Change inner circle, if dist inner-circle to edge is very small -> sharp edges.
  - Nav-Mesh Generation verbessern? -> use lower-detail version of terrain?
- Thread-Safe materials?


## VFX / Shader Ideas/Inspo
- https://godotshaders.com/shader/raymarched-3d-noise-decal/
