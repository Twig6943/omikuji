fn main() {
    println!("cargo:rerun-if-changed=proto/SophonPatch.proto");
    println!("cargo:rerun-if-changed=proto/SophonManifest.proto");
    prost_build::compile_protos(
        &["proto/SophonPatch.proto", "proto/SophonManifest.proto"],
        &["proto/"],
    )
    .expect("failed to compile sophon protos");
}
