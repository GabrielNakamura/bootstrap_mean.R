#bootstrap function for mean

bootstrap_mean<- function(x, sub.samples, iterations= 999, all_boot= FALSE){
    if(is.matrix(x)==TRUE){
        if(length(which(x>1))>=1){
                stop("X must be a presence-absence matrix or mean_abundance argument be TRUE")
            }
            boot.riq<-matrix(NA, length(sub.samples), iterations, byrow= FALSE, dimnames = list(paste(sub.samples,"samples", sep = "_"), paste(1:iterations, "iter", sep="_")))
            boot.sd<-matrix(NA, length(sub.samples), iterations, byrow= FALSE, dimnames = list(paste(sub.samples,"samples", sep = "_"), paste(1:iterations, "iter", sep="_")))
            for(j in 1:iterations){
                for(i in 1:length(sub.samples)){
                    ric.boot<-x[sample(1:nrow(x), size = sub.samples[i], replace= TRUE),]
                    boot.riq[i,j]<-mean(rowSums(ric.boot))
                    boot.sd[i,j]<-sd(rowSums(ric.boot))
                }
            }
            confint<-matrix(NA, 2, length(sub.samples),dimnames=list(paste(c("lower","upper"),"limit",sep="_"),paste(sub.samples,"samples", sep = "_")), 
                            byrow=FALSE)
            for(i in 1:nrow(boot.riq)){
                confint[,i]<-quantile(sort(boot.riq[i,]),c(0.025, 0.975))
            }
            average_means<- apply(boot.riq, 1, mean)
            average_sd<- apply(boot.sd, 1, mean)
            diff_up_lower<- confint[2,]-confint[1,]
            if(all_boot==TRUE){
                bootstrap_results_complete<-list(Average_means=average_means,
                                                 Confidence_intervals=confint,
                                                 Average_standard_deviation=average_sd,
                                                 differences_up_lower_limits=diff_up_lower,
                                                 Matrix_bootstrap_means=boot.riq,
                                                 Matrix_bootstrap_standard_deviation=boot.sd)
                return(bootstrap_results_complete)
            } 
            if(all_boot==FALSE){
                bootstrap_results<-list(Average_means=average_means,
                                        Confidence_intervals=confint,
                                        Average_standard_deviation=average_sd,
                                        differences_up_lower_limits=diff_up_lower)
                return(bootstrap_results)
            } 
    }
    if(is.vector(x)==TRUE){
        boot.mean<- matrix(NA, length(sub.samples), iterations, dimnames = list(paste(sub.samples,"samples", sep = "_"), paste(1:iterations, "iter", sep="_")))
        boot.sd.vect<-matrix(NA, length(sub.samples), iterations, dimnames = list(paste(sub.samples,"samples", sep = "_"), paste(1:iterations, "iter", sep="_")))
        for(j in 1:iterations){
            for(i in 1:length(sub.samples)){
                boot<-sample(x, size = sub.samples[i], replace= TRUE)
                boot.mean[i,j]<-mean(boot)
                boot.sd.vect[i,j]<-sd(boot)
            }
        }
        confint<-matrix(NA, 2, length(sub.samples),dimnames=list(paste(c("lower","upper"),"limit",sep="_"),paste(sub.samples,"samples", sep = "_")), 
                        byrow=FALSE)
        for(i in 1:nrow(boot.mean)){
            confint[,i]<-quantile(sort(boot.mean[i,]),c(0.025, 0.975))
        }
        average_means<- apply(boot.mean, 1, mean)
        average_sd<- apply(boot.sd.vect,1,mean)
        diff_up_lower<- confint[2,]-confint[1,]
        if(all_boot==TRUE){
            bootstrap_results_complete<-list(Average_means= average_means, 
                                             Confidence_intervals=confint,
                                             Average_standard_deviation=average_sd,
                                             differences_up_lower_limits=diff_up_lower,
                                             Matrix_bootstrap_means= boot.mean,
                                             Matrix_bootstrap_standard_deviation= boot.sd.vect)
            return(bootstrap_results_complete)
        } 
        if(all_boot==FALSE){
            bootstrap_results<-list(Average_means= average_means,
                                    Confidence_intervals=confint, 
                                    Average_standard_deviation=average_sd, 
                                    differences_up_lower_limits=diff_up_lower)
            return(bootstrap_results)
        }
    }
}