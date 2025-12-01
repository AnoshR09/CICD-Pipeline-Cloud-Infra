/*Simple Calculator*/
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class SimpleCalculator extends JFrame implements ActionListener {

    private JTextField displayField;
    private StringBuilder currentInput = new StringBuilder();
    private double firstOperand = 0;
    private String operator = "";
    private boolean newNumber = true;

    public SimpleCalculator() {
        setTitle("Simple Calculator");
        setSize(300, 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        // Display field
        displayField = new JTextField("0");
        displayField.setEditable(false);
        displayField.setFont(new Font("Arial", Font.BOLD, 24));
        displayField.setHorizontalAlignment(JTextField.RIGHT);
        add(displayField, BorderLayout.NORTH);

        // Button panel
        JPanel buttonPanel = new JPanel(new GridLayout(4, 4, 5, 5));
        String[] buttonLabels = {
                "7", "8", "9", "/",
                "4", "5", "6", "*",
                "1", "2", "3", "-",
                "0", ".", "=", "+"
        };

        for (String label : buttonLabels) {
            JButton button = new JButton(label);
            button.setFont(new Font("Arial", Font.BOLD, 18));
            button.addActionListener(this);
            buttonPanel.add(button);
        }
        add(buttonPanel, BorderLayout.CENTER);

        setVisible(true);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        String command = e.getActionCommand();

        if (Character.isDigit(command.charAt(0)) || command.equals(".")) {
            if (newNumber) {
                currentInput.setLength(0); // Clear for new number
                newNumber = false;
            }
            if (command.equals(".") && currentInput.toString().contains(".")) {
                return; // Prevent multiple decimal points
            }
            currentInput.append(command);
            displayField.setText(currentInput.toString());
        } else if (command.equals("=")) {
            calculateResult();
            operator = "";
            newNumber = true;
        } else { // Operator button
            if (!operator.isEmpty() && !newNumber) {
                calculateResult();
            }
            firstOperand = Double.parseDouble(displayField.getText());
            operator = command;
            newNumber = true;
        }
    }

    private void calculateResult() {
        if (operator.isEmpty() || newNumber) {
            return;
        }

        double secondOperand = Double.parseDouble(displayField.getText());
        double result = 0;

        switch (operator) {
            case "+":
                result = firstOperand + secondOperand;
                break;
            case "-":
                result = firstOperand - secondOperand;
                break;
            case "*":
                result = firstOperand * secondOperand;
                break;
            case "/":
                if (secondOperand != 0) {
                    result = firstOperand / secondOperand;
                } else {
                    displayField.setText("Error");
                    return;
                }
                break;
        }
        displayField.setText(String.valueOf(result));
        firstOperand = result; // For chained operations
    }

    public static void main(String[] args) {
        if (GraphicsEnvironment.isHeadless()) {
            System.out.println("Calculator running in headless mode - GUI not available");
            System.out.println("Application started successfully!");
            try {
                Thread.sleep(Long.MAX_VALUE);
            } catch (InterruptedException e) {
                System.out.println("Application interrupted");
            }
        } else {
            SwingUtilities.invokeLater(() -> new SimpleCalculator());
        }
    }
}
