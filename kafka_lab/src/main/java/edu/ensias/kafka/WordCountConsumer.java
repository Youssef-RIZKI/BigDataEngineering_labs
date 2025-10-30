package edu.ensias.kafka;

import java.util.*;
import java.time.Duration;
import org.apache.kafka.clients.consumer.*;
import org.apache.kafka.common.serialization.StringDeserializer;

public class WordCountConsumer {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("Veuillez spécifier le nom du topic.");
            return;
        }

        String topicName = args[0];
        Properties props = new Properties();
        props.put("bootstrap.servers", "localhost:9092");
        props.put("group.id", "wordcount-group");
        props.put("enable.auto.commit", "true");
        props.put("auto.commit.interval.ms", "1000");
        props.put("key.deserializer", StringDeserializer.class.getName());
        props.put("value.deserializer", StringDeserializer.class.getName());

        KafkaConsumer<String, String> consumer = new KafkaConsumer<>(props);
        consumer.subscribe(Collections.singletonList(topicName));

        Map<String, Integer> wordCounts = new HashMap<>();
        System.out.println("Lecture des mots depuis Kafka...");

        while (true) {
            ConsumerRecords<String, String> records = consumer.poll(Duration.ofMillis(100));
            for (ConsumerRecord<String, String> record : records) {
                String word = record.value();
                wordCounts.put(word, wordCounts.getOrDefault(word, 0) + 1);
                System.out.println("Mot : " + word + " → Fréquence : " + wordCounts.get(word));
            }
        }
    }
}
