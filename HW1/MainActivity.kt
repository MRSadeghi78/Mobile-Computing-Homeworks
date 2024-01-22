package com.example.composetutorial

import android.content.res.Configuration
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.Image
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.RectangleShape
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.composetutorial.ui.theme.ComposeTutorialTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            ComposeTutorialTheme {
                Surface(modifier = Modifier.fillMaxSize(), color = MaterialTheme.colorScheme.background) {
                    ContentList(len = 6)
                }
            }
        }
    }
}

@Composable
fun MessageCard(capNumber: Number) {
    var isExpanded by remember { mutableStateOf(false)}
    Column(
        modifier = Modifier
            .width(350.dp),
                horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Image(
            painter = painterResource(R.drawable.landscape_nature_sky_rain_field_clouds_188646_wallhere_com),
            contentDescription = "icon image",
            modifier = Modifier
                .clickable { isExpanded = !isExpanded }
                .padding(horizontal = 20.dp)
                .size(if (isExpanded) 200.dp else 100.dp)
                .clip(shape = if (isExpanded) CircleShape else RectangleShape)
        )
        Text(
            text = "Hello World" + capNumber,
            color = MaterialTheme.colorScheme.outline,
            style = MaterialTheme.typography.headlineLarge
        )
        Text(
            text = "Terve!",
            color = MaterialTheme.colorScheme.onTertiaryContainer,
            style = MaterialTheme.typography.labelMedium

        )
    }
}

@Composable
fun ContentList(len: Int) {
    var caps = ArrayList<Int>()
    for (i in 1..len) {
        caps.add(i)
    }
    LazyColumn {
        items(caps) {
            cap ->
            MessageCard(cap)
        }
    }
}

@Preview(
    showBackground = true,
)
@Composable
fun PreviewMessageCard() {
    ComposeTutorialTheme {
        ContentList(len = 6)
    }
}
