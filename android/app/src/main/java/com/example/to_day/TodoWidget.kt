package com.example.to_day

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.app.PendingIntent
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import org.json.JSONArray

/**
 * Implementation of App Widget functionality.
 */
class TodoWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.todo_widget).apply{
                // get data from flutter as JSON
                val fromFlutterApp = widgetData.getString("text_from_todo_app", "[]")

                // convert JSON to a list
                val todos = try {
                    JSONArray(fromFlutterApp)
                } catch (e: Exception) {
                    JSONArray()
                }

                // create a String to display in the text
                val text = StringBuilder()

                if(todos.length() <= 9)
                {
                    for (i in 0 until todos.length()) {
                        text.append("• ").append(todos.getString(i)).append("\n")
                    }
                }else
                {
                    for (i in 0 until 7) {
                        text.append("• ").append(todos.getString(i)).append("\n")
                    }
                    text.append("and ${todos.length()-7} more...")
                }


                // display on screen
                setTextViewText(R.id.todo_text, text.toString())
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)

            val intent = context.packageManager
                .getLaunchIntentForPackage(context.packageName)

            val pendingIntent = PendingIntent.getActivity(
                context,
                0,
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )

            views.setOnClickPendingIntent(R.id.background, pendingIntent)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}