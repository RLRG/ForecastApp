//
//  MainVC_WITAI.swift
//  ForecastApp
//
//  Created by Rodrigo López-Romero Guijarro on 01/05/2018.
//  Copyright © 2018 rlrg. All rights reserved.
//

import Foundation
import Wit

// TODO: Include comments the extension and all the functions
extension MainVC: WitDelegate {
    
    func witDidDetectSpeech() {
        #if DEBUG
        print("WIT AI EVENT: witDidDetectSpeech() called")
        #endif
    }
    
    func witDidStartRecording() {
        #if DEBUG
        print("WIT AI EVENT: witDidStartRecording() called")
        #endif
    }
    
    func witDidStopRecording() {
        #if DEBUG
        print("WIT AI EVENT: witDidStopRecording() called")
        #endif
    }
    
    func witActivityDetectorStarted() {
        #if DEBUG
        print("WIT AI EVENT: witActivityDetectorStarted() called")
        #endif
    }
    
    func witDidGetAudio(_ chunk: Data!) {
        #if DEBUG
        print("WIT AI EVENT: witDidGetAudio() called")
        #endif
    }
    
    func witReceivedRecordingError(_ error: Error!) {
        #if DEBUG
        print("WIT AI EVENT: witReceivedRecordingError() called with error: \(error.localizedDescription)")
        #endif
    }
    
    func witDidRecognizePreviewText(_ previewText: String!, final isFinal: Bool) {
        #if DEBUG
        print("WIT AI EVENT: witDidRecognizePreviewText() called with previewText: \(previewText) and isFinal = \(isFinal)")
        #endif
    }
    
    func witDidGraspIntent(_ outcomes: [Any]!, messageId: String!, customData: Any!, error: Error!) {
        #if DEBUG
        print("WIT AI EVENT: witDidGraspIntent() called with")
        #endif
        // The following IF means that we have received from WIT AI the specific INTENT we are waiting for, the one which has been set up in the WIT AI website. This means that the received answer from the server would be:
        // { "_text" : "can you give me the temperature, the wind and the precipitation for the next 3 hours?" : [
        // ...
        // "entities" : {"weatherUserIntent" : [{ "value": "weatherForNext3Hours" ... }]}
        //  ....
        // }
        if let result = outcomes.first as? [String:Any], let entity = result["entities"] as? [String:Any],
            let _ = entity["weatherUserIntent"] {
            self.refreshAction(self.refreshButton) // IF this happens, what we do for now is to refresh the data on the screen.
        }
    }
    
    func didStop(_ session: WitSession!) {
        #if DEBUG
        print("WIT AI EVENT: didStop() called.")
        #endif
    }
}
