package com.example.mobileassignment3

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.mobileassignment3.ui.theme.MobileAssignment3Theme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MobileAssignment3Theme {
                BudgetScreen()
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun BudgetScreen() {
    var budgetAmount by remember { mutableStateOf(TextFieldValue("")) }
    var totalBudget by remember { mutableStateOf(0.0) }

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Budgeting App") }
            )
        },
        content = { padding ->
            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(padding)
                    .padding(16.dp),
                horizontalAlignment = Alignment.Start
            ) {
                // Input field for entering the budget
                Text("Enter your budget amount:")
                BasicTextField(
                    value = budgetAmount,
                    onValueChange = { budgetAmount = it },
                    modifier = Modifier.fillMaxWidth()
                )

                Spacer(modifier = Modifier.height(16.dp))

                // Button to set the budget
                Button(onClick = {
                    totalBudget = budgetAmount.text.toDoubleOrNull() ?: 0.0
                }) {
                    Text("Set Budget")
                }

                Spacer(modifier = Modifier.height(16.dp))

                // Display the total budget
                Text("Your Budget: \$${"%.2f".format(totalBudget)}")
            }
        }
    )
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    MobileAssignment3Theme {
        BudgetScreen()
    }
}
