package edu.ensias.hadoop.hdfslab;

import java.io.IOException;
//import java.util.StringTokenizer;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.Mapper;

public class TokenizerMapper extends Mapper<Object, Text, Text, IntWritable> {
    private final static IntWritable one = new IntWritable(1); // the value to use t=in th key_value

    // Cette méthode est appelée automatiquement par Hadoop pour chaque ligne du
    // fichier.
    public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
        // System.out.println(key.toString());
        // Text word =;

        String line = value.toString();
        String[] words = line.split("\\W+");
        for (String w : words) {
            // - context : utilisé pour émettre les paires (clé, valeur) vers le système
            // MapReduce
            context.write(new Text(w), one);
        }
    }
}
