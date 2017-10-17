// ---------------------------------------
// Sprite definitions for 'HedgehogAnim_Sheet'
// Generated with TexturePacker 3.7.1
//
// http://www.codeandweb.com/texturepacker
// ---------------------------------------

import SpriteKit


class HedgehogAnim_Code {

    // sprite names
    let HEDGEHOG_ANIMATION0001 = "Hedgehog_Animation0001"
    let HEDGEHOG_ANIMATION0002 = "Hedgehog_Animation0002"
    let HEDGEHOG_ANIMATION0003 = "Hedgehog_Animation0003"
    let HEDGEHOG_ANIMATION0004 = "Hedgehog_Animation0004"
    let HEDGEHOG_ANIMATION0005 = "Hedgehog_Animation0005"


    // load texture atlas
    let textureAtlas = SKTextureAtlas(named: "HedgehogAnim_Sheet")


    // individual texture objects
    func Hedgehog_Animation0001() -> SKTexture { return textureAtlas.textureNamed(HEDGEHOG_ANIMATION0001) }
    func Hedgehog_Animation0002() -> SKTexture { return textureAtlas.textureNamed(HEDGEHOG_ANIMATION0002) }
    func Hedgehog_Animation0003() -> SKTexture { return textureAtlas.textureNamed(HEDGEHOG_ANIMATION0003) }
    func Hedgehog_Animation0004() -> SKTexture { return textureAtlas.textureNamed(HEDGEHOG_ANIMATION0004) }
    func Hedgehog_Animation0005() -> SKTexture { return textureAtlas.textureNamed(HEDGEHOG_ANIMATION0005) }


    // texture arrays for animations
    func Hedgehog_Roll() -> [SKTexture] {
        return [
            Hedgehog_Animation0001(),
            Hedgehog_Animation0002(),
            Hedgehog_Animation0003(),
            Hedgehog_Animation0004(),
            Hedgehog_Animation0005()
        ]
    }


}
