OS=`uname -s`

if [ "$OS" == "Darwin" ]; then
	echo "Mac OS X with Darwin Kernel"
	cp extract_ruby_mac extract_ruby
elif [ "$OS" == "Linux" ]; then
	echo "GNU/Linux OS with Linux Kernel"
	g++ -std=c++11 extract_ruby.cpp -o extract_ruby
else
	echo "Not Mac or Linux"
fi
