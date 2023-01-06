#ifndef STATS_H
#define STATS_H

std::vector< double > getInput( std::istream& input_stream );
double calculateSum( const std::vector< double >& numbers );
double calculateProduct( const std::vector< double >& numbers );
size_t calculateCount( const std::vector< double >& numbers );
double calculateAverage( const std::vector< double >& numbers );
double calculateMedian( const std::vector< double >& numbers );
double calculateMinimum( const std::vector< double >& numbers );
double calculateMaximum( const std::vector< double >& numbers );

#endif

