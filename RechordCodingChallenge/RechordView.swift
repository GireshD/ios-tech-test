//
//  RechordView.swift
//  RechordCodingChallenge
//
//  Created by Dan Wartnaby on 11/04/2022.
//

import SwiftUI
import AudioKit

struct RechordView: View {
    var viewModel: RechordViewModel
    
    @State var showFileBrowser: Bool = false
    @State var isPlaying: Bool = false
    @State var fileURL = URL(fileURLWithPath: "")
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("RECHORD TEST")
                    .font(.headline)
                
                Text("Rechord is all about Audio. This test app uses AudioKit to load and play audio files... but it's just not very good. It has problems. Please, Fix Me!").multilineTextAlignment(.leading).font(.body)
                
                Button(action: {
                    showFileBrowser = true
                })
                {
                    Text("BROWSE FILES...")
                }
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(Color("Button_Foreground"))
                .background(Color("Button_Background"))
                .cornerRadius(7)
                
                Button(action: {
                    let file = Bundle.main.url(forResource: "loop", withExtension: "wav")!
                    viewModel.loadAudio(from: file)
                    viewModel.looping()
                    isPlaying = false
                })
                {
                    Text("LOAD A TEST LOOP")
                }
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(Color("Button_Foreground"))
                .background(Color("Button_Background"))
                .cornerRadius(7)
                
                Button(action: {
                    isPlaying.toggle()
                    
                    if isPlaying {
                        viewModel.play()
                    }
                    else {
                        viewModel.stop()
                    }
                })
                {
                    Text("PLAY OR STOP")
                }
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(Color("Button_Foreground"))
                .background(Color("Button_Background"))
                .cornerRadius(7)
            }
            .padding(30)
            .onAppear {
                viewModel.startEngine()
            }
            .fileImporter(
                        isPresented: $showFileBrowser,
                        allowedContentTypes: [.audio],
                        allowsMultipleSelection: false
                    ) { result in
                        do {
                            fileURL = try result.get().first!
                            if (CFURLStartAccessingSecurityScopedResource(fileURL as CFURL)) {
                                Log(fileURL.absoluteString)
                                viewModel.loadAudio(from: fileURL)
                                isPlaying = false
                                CFURLStopAccessingSecurityScopedResource(fileURL as CFURL)
                                }
                                else {
                                    print("Permission error!")
                                }
                        } catch  {
                            Log(error.localizedDescription, type: .error)
                        }
                    }
        }
    }
}

struct RechordView_Previews: PreviewProvider {
    static var previews: some View {
        RechordView(viewModel: RechordViewModel())
    }
}
