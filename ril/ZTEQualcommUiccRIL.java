/*
 * Copyright (C) 2012 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.android.internal.telephony;

import static com.android.internal.telephony.RILConstants.*;

import android.content.Context;
import android.media.AudioManager;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Looper;
import android.os.Message;
import android.os.Parcel;
import android.telephony.SmsMessage;
import android.os.SystemProperties;
import android.os.SystemClock;
import android.provider.Settings;
import android.text.TextUtils;
import android.telephony.Rlog;
import android.telephony.SignalStrength;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;

import com.android.internal.telephony.uicc.IccCardApplicationStatus;
import com.android.internal.telephony.uicc.IccCardStatus;

public class ZTEQualcommUiccRIL extends RIL implements CommandsInterface {
    protected int mPinState;
    
    public ZTEQualcommUiccRIL(Context context, int networkMode, int cdmaSubscription) {
        super(context, networkMode, cdmaSubscription);
    }

    @Override
    protected Object
    responseIccCardStatus(Parcel p) {
        IccCardApplicationStatus appStatus;

        boolean oldRil = needsOldRilFeature("icccardstatus");

        IccCardStatus cardStatus = new IccCardStatus();
        cardStatus.setCardState(p.readInt());
        cardStatus.setUniversalPinState(p.readInt());
        cardStatus.mGsmUmtsSubscriptionAppIndex = p.readInt();
        cardStatus.mCdmaSubscriptionAppIndex = p.readInt();

        if (!oldRil)
            cardStatus.mImsSubscriptionAppIndex = p.readInt();
            
		p.readInt(); //pinRetry
		p.readInt(); //pin2Retry

        int numApplications = p.readInt();

        // limit to maximum allowed applications
        if (numApplications > IccCardStatus.CARD_MAX_APPS) {
            numApplications = IccCardStatus.CARD_MAX_APPS;
        }
        cardStatus.mApplications = new IccCardApplicationStatus[numApplications];

        for (int i = 0 ; i < numApplications ; i++) {
            appStatus = new IccCardApplicationStatus();
            appStatus.app_type       = appStatus.AppTypeFromRILInt(p.readInt());
            appStatus.app_state      = appStatus.AppStateFromRILInt(p.readInt());
            appStatus.perso_substate = appStatus.PersoSubstateFromRILInt(p.readInt());
            appStatus.aid            = p.readString();
            appStatus.app_label      = p.readString();
            appStatus.pin1_replaced  = p.readInt();
            appStatus.pin1           = appStatus.PinStateFromRILInt(p.readInt());
            appStatus.pin2           = appStatus.PinStateFromRILInt(p.readInt());
            cardStatus.mApplications[i] = appStatus;
        }
        return cardStatus;
    }
    
    @Override
    protected Object
    responseSignalStrength(Parcel p) {
        int numInts = 14;
        int response[];
        boolean isGsm = true;

        /* TODO: Add SignalStrength class to match RIL_SignalStrength */
        response = new int[numInts];
        for (int i = 0 ; i < numInts ; i++) {
			response[i] = p.readInt();
        }
        
        if(response[2] > 10)
        	response[2] = response[2]-10;
        if(response[4] > 10)
        	response[4] = response[4]-10;

        isGsm = (response[13] != 0);
/*
------------------------------------------
    0     mGsmSignalStrength = m.getInt("GsmSignalStrength");
    1     mGsmBitErrorRate = m.getInt("GsmBitErrorRate");
    2     mCdmaDbm = m.getInt("CdmaDbm");
    3     mCdmaEcio = m.getInt("CdmaEcio");
    4     mEvdoDbm = m.getInt("EvdoDbm");
    5     mEvdoEcio = m.getInt("EvdoEcio");
    6     mEvdoSnr = m.getInt("EvdoSnr");
    7     mLteSignalStrength = m.getInt("LteSignalStrength"); // 0 to 63
    8     mLteRsrp = m.getInt("LteRsrp"); // -44 to -140
    9     mLteRsrq = m.getInt("LteRsrq");
   10     mLteRssnr = m.getInt("LteRssnr"); // -200 dB to +300
   11     mLteCqi = m.getInt("LteCqi");
   12     mLteCqi = m.getInt("LteCqi");
   13     isGsm = m.getBoolean("isGsm");
------------------------------------------
INVALID = 0x7FFFFFFF (2147483647)

getAsuLevel() 
  -->getLteLevel()----> getGsmAsuLevel() --> getGsmSignalStrength() --> mGsmSignalStrength
                  \---> getLteAsuLevel() --> mLteRsrp == INVALID? 255 : mLteRsrp +140
getDbm()
  -->getLteLevel()----> getGsmDbm() --> (-113 + 2x mGsmSignalStrength)
                  \---> mLteRsrp

frameworks/base/telephony/java/android/telephony/SignalStrength.java
------------------------------------------
*/
        return new SignalStrength(response[0], 
        						  response[1], 
        						  response[2], 
        						  response[3], 
        						  response[4], 
        						  response[5], 
        						  response[6], 
        						  response[7],
        						  response[8], 
        						  response[9], 
        						  response[10], 
        						  response[11], 
        						  response[12], 
        						  isGsm);
    }
    
    @Override
    public void getImsRegistrationState(Message result) {
        if(mRilVersion >= 8)
            super.getImsRegistrationState(result);
        else {
            if (result != null) {
                CommandException ex = new CommandException(
                    CommandException.Error.REQUEST_NOT_SUPPORTED);
                AsyncResult.forMessage(result, null, ex);
                result.sendToTarget();
            }
        }
    }

}

