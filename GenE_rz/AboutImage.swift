//jacob about image https://github.com/Jacobvazquez18/GenE_UPDATED/blob/main/AboutImage
import SwiftUI

struct AboutImage: View {
    var body: some View {
        Image("Image")
            .resizable()
            .frame(width: 840, height: 500)
    }
}

struct AboutImage_Previews: PreviewProvider {
    static var previews: some View {
        AboutImage()
    }
}
