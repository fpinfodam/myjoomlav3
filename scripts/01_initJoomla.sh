#!/bin/bash
cd ../bin/joomla3

cp Jomla3.tgz ./joomla

cd joomla

tar xfv Jomla3.tgz

rm Jomla3.tgz

mv * ../../../joomla3-www

cd ..
