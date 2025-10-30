package edu.ensias.kafka;

import java.util.Properties;
import java.util.Scanner;
import org.apache.kafka.clients.producer.*;

public class WordProducer {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("Veuillez spécifier le nom du topic.");
            return;
        }

        String topicName = args[0];
        Properties props = new Properties();
        props.put("bootstrap.servers", "localhost:9092");
        props.put("acks", "all");
        props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");

        Producer<String, String> producer = new KafkaProducer<>(props);
        Scanner scanner = new Scanner(System.in);

        System.out.println("Saisissez du texte (Ctrl+C pour quitter) :");
        while (scanner.hasNextLine()) {
            String line = scanner.nextLine();
            String[] words = line.split("\\W+");
            for (String word : words) {
                if (!word.isEmpty()) {
                    producer.send(new ProducerRecord<>(topicName, null, word.toLowerCase()));
                }
            }
        }

        producer.close();
        scanner.close();
    }
}
