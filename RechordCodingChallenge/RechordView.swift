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
            VStack(spacing: 15) {
                Text("RECHORD TEST")
                    .font(.headline)
                
                Text("Rechord is all about Audio. This test app uses AudioKit to load and play audio files... but it's just not very good. It has problems. Please, Fix Me!").multilineTextAlignment(.leading).font(.body)
                
                fileNameLbl
                
                buttons
                
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

extension RechordView{
    
    private var fileNameLbl: some View{
        HStack{
            if fileURL.absoluteString.count>8{
                Text(fileURL.deletingPathExtension().lastPathComponent).multilineTextAlignment(.center).font(.caption)
            }
        }
    }
    
    private var isPlayerAvailable: Bool{
        return fileURL.absoluteString.count>8
    }
    
    private var buttons: some View {
        VStack(spacing: 15){
            
            CustomButton(title: "BROWSE FILES...")
                .onTapGesture {
                    showFileBrowser = true
                }
            
            
            CustomButton(title: "LOAD A TEST LOOP")
                .onTapGesture {
                    fileURL = Bundle.main.url(forResource: "loop", withExtension: "wav")!
                    viewModel.loadAudio(from: fileURL)
                    viewModel.looping()
                    isPlaying = false
                }
            
            CustomButton(title: (isPlaying  ?  "STOP" : "Play"))
                .onTapGesture {
                    if viewModel.player != nil{
                        isPlaying.toggle()
                        isPlaying ?  viewModel.play() : viewModel.stop()
                    }
                }
                .opacity(isPlayerAvailable ? 1 : 0.5)
        }
    }
}

struct RechordView_Previews: PreviewProvider {
    static var previews: some View {
        RechordView(viewModel: RechordViewModel())
    }
}
