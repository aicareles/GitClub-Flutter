package com.i502tech.gitclub;

import android.annotation.TargetApi;
import android.app.WallpaperManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build;
import android.os.Bundle;

import java.io.File;
import java.io.IOException;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugins.GeneratedPluginRegistrant;

/**
 * description $desc$
 * created by jerry on 2019/1/21.
 */
public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "gitclub.com.wallpaper/wallpaper";

    @Override
    public void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        if (call.method.equals("setWallpaper")) {
                            int setWallpaper=setWallpaper((String) call.arguments);
                            //int setWallpaper = getBatteryLevel();

                            if (setWallpaper ==0) {
                                result.success(setWallpaper);
                            } else {
                                result.error("UNAVAILABLE", "", null);
                            }
                        } else {
                            result.notImplemented();
                        }
                    }
                });
    }


    @TargetApi(Build.VERSION_CODES.ECLAIR)
    private int setWallpaper(String path) {
        int setWallpaper = 1;
        File imgFile = new  File(this.getApplicationContext().getCacheDir(), path);
        // set bitmap to wallpaper
        Bitmap bitmap = BitmapFactory.decodeFile(imgFile.getAbsolutePath());
        WallpaperManager wm = null;
        //if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ECLAIR) {
        wm = WallpaperManager.getInstance(this);
        // }
        try{
            // if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ECLAIR) {
            wm.setBitmap(bitmap);
            //  }
            setWallpaper=0;
        }catch (IOException e){
            setWallpaper=1;
        }
        return setWallpaper;
    }
}
