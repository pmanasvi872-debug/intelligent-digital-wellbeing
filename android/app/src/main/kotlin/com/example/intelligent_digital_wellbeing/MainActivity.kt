package com.example.intelligent_digital_wellbeing

import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "digital_wellbeing/usage"

    override fun configureFlutterEngine(
        flutterEngine: FlutterEngine
    ) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {

                // -----------------------------------------
                // GET APP USAGE STATISTICS
                // -----------------------------------------
                "getUsageStats" -> {

                    val usageStatsManager =
                        getSystemService(
                            Context.USAGE_STATS_SERVICE
                        ) as UsageStatsManager

                    val endTime =
                        System.currentTimeMillis()

                    val startTime =
                        endTime -
                            (24 * 60 * 60 * 1000)

                    val usageStats =
                        usageStatsManager.queryUsageStats(
                            UsageStatsManager.INTERVAL_DAILY,
                            startTime,
                            endTime
                        )

                    val usageData = usageStats
                        .filter {
                            it.totalTimeInForeground > 0
                        }
                        .map {

                            // Get human-readable app name
                            var appName =
                                it.packageName

                            try {
                                val applicationInfo =
                                    packageManager.getApplicationInfo(
                                        it.packageName,
                                        0
                                    )

                                appName =
                                    packageManager
                                        .getApplicationLabel(
                                            applicationInfo
                                        )
                                        .toString()

                            } catch (e: Exception) {
                                // Keep package name if app name
                                // cannot be found
                                appName =
                                    it.packageName
                            }

                            mapOf(
                                "packageName" to
                                    it.packageName,

                                "appName" to
                                    appName,

                                "usageTime" to
                                    it.totalTimeInForeground
                            )
                        }

                    result.success(usageData)
                }

                // -----------------------------------------
                // GET APP USAGE EVENTS
                // -----------------------------------------
                "getUsageEvents" -> {

                    val usageStatsManager =
                        getSystemService(
                            Context.USAGE_STATS_SERVICE
                        ) as UsageStatsManager

                    val endTime =
                        System.currentTimeMillis()

                    val startTime =
                        endTime -
                            (24 * 60 * 60 * 1000)

                    val events =
                        usageStatsManager.queryEvents(
                            startTime,
                            endTime
                        )

                    val eventList =
                        mutableListOf<Map<String, Any>>()

                    val event =
                        UsageEvents.Event()

                    while (events.hasNextEvent()) {

                        events.getNextEvent(event)

                        if (
                            event.eventType ==
                                UsageEvents.Event
                                    .ACTIVITY_RESUMED
                        ) {

                            eventList.add(
                                mapOf(
                                    "packageName" to
                                        event.packageName,

                                    "timestamp" to
                                        event.timeStamp,

                                    "eventType" to
                                        "foreground"
                                )
                            )
                        }

                        else if (
                            event.eventType ==
                                UsageEvents.Event
                                    .ACTIVITY_PAUSED
                        ) {

                            eventList.add(
                                mapOf(
                                    "packageName" to
                                        event.packageName,

                                    "timestamp" to
                                        event.timeStamp,

                                    "eventType" to
                                        "background"
                                )
                            )
                        }
                    }

                    result.success(eventList)
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}