# 1. Previsualizar el contenido con la funcion head(). 

head(mtcars)

#2. Mirar el numero de ???las y columnas con nrow() y ncol(). 

nrow(mtcars)
ncol(mtcars)

#3. Crear un nuevo data frame con los modelos de coche que consumen menos de 15 millas/gal´on. 

mtcarslow <- mtcars[mtcars$mpg < 15,]
print (mtcarslow)

#4. Ordenar el data frame anterior por disp

attach(mtcarslow)
mtcarslow[order(disp),]
detach(mtcarslow)

#5. Calcular la media de las marchas (gear) de los modelos del data frame anterior. 

attach(mtcarslow)
mean(gear)
detach(mtcarslow)

#6. Cambiar los nombres de las variables del data frame a var1, var2, ..., var11. 

x <- c("var")
y <- seq(1,11)
?paste
z <- paste(x,y, sep="")
print (z)

names(mtcars) <- paste(z)
mtcars

#1. ¿Como esta estructurado el data frame? (utilizar las funciones str() y dim()). 

str(iris)
dim(iris)

#2. ¿De qu´e tipo es cada una de las variables del data frame?.

sapply(iris, class)

#3. Utilizar la funci´on summary() para obtener un resumen de los estad´isticos de las variables

summary(iris)

#Sepal.Length    Sepal.Width     Petal.Length    Petal.Width          Species  
#Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100   setosa    :50  
#1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300   versicolor:50  
#Median :5.800   Median :3.000   Median :4.350   Median :1.300   virginica :50  
#Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199                  
#3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800                  
#Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500

#4. Comprobar con las funciones mean(), range(), que se obtienen los mismos valores

sapply(iris,mean)

#Sepal.Length  Sepal.Width Petal.Length  Petal.Width      Species 
#5.843333     3.057333     3.758000     1.199333           NA

range(iris[[1]])
#4.3 7.9
range(iris[[2]])
#2.0 4.4
range(iris[[3]])
#1.0 6.9
range(iris[[4]])
#0.1 2.5
range(iris[[5]])
#NA

#Si, se obtienen los mismo valores.

#5. Cambia los valores de las variables Sepal.Length Sepal.Width de las 5 primeras observaciones por NA. 

iris$Sepal.Length[1:5] <- NA
iris$Sepal.Width[1:5] <- NA

#6. ¿Que pasa si usamos ahora las funciones mean(), range() con las variables Sepal.Length y Sepal.Width? ¿Tiene el mismo problema la funci´on summary()?

#No se calcula mean() ni range().

summary(iris$Petal.Length)

#summary() da resultados. 

#7. Ver la documentaci´on de mean(), range(), etc. ¿Qu´e par´ametro habr´ia que cambiar para arreglar el problema anterior?

mean (iris$Sepal.Length, na.rm =TRUE)
mean (iris$Sepal.Width, na.rm =TRUE)

#8. Visto lo anterior, ¿por qu´e es importante codi???car los missing values como NA y no como 0, por ejemplo

# ceros falsifican el resultado, mientras NA puede ser omitido.

#9. Eliminar los valores NA usando na.omit()

na.omit(iris$Sepal.Length)
na.omit(iris$Sepal.Width)

#10 Calcular la media de la variable Petal.Length para cada uno de las distintas especies (Species). Pista: usar la funci´on tapply().

tapply(iris$Petal.Length, INDEX = iris$Species,mean)
# o
tapply(iris[,3], INDEX = iris$Species,mean)

#setosa versicolor  virginica 
#1.462      4.260      5.552 


